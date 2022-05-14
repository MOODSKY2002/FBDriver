#include once "inc\FBDriverMod.bi"

'驱动入口函数导出 drive entry function export
declare function DriverEntry stdcall alias "DriverEntry" (byval pDriverObject as PDRIVER_OBJECT, byval pRegistryPath as PUNICODE_STRING) as NTSTATUS

'驱动入口函数 drive entry function
function DriverEntry(byval pDriverObject as PDRIVER_OBJECT,byval pRegistryPath as PUNICODE_STRING) as NTSTATUS 
   dim Status as NTSTATUS = STATUS_SUCCESS
   dim as UNICODE_STRING DEVICE_NAME,LINK_NAME,EVENT_NAME
   dim i as integer

   DbgPrint(@!"%ws DriverEntry Start \r\n",My_DRIVE_NAME)

   '初始化
   for i = 0 to IRP_MJ_MAXIMUM_FUNCTION - 1
      pDriverObject->MajorFunction(i) = @FBDriver_UnsupportedFunction
   next

   with *pDriverObject
      .MajorFunction(IRP_MJ_CLOSE)          = @FBDriver_Create '@FBDriver_Close
      .MajorFunction(IRP_MJ_CREATE)         = @FBDriver_Create
      .MajorFunction(IRP_MJ_DEVICE_CONTROL) = @FBDriver_IoControl
      '.MajorFunction(IRP_MJ_READ)          = @FBDriver_Read
      '.MajorFunction(IRP_MJ_WRITE)         = @FBDriver_Write
      .DriverUnload                         = @FBDriver_Unload
      .Flags or = DO_BUFFERED_IO
      '.Flags or = DO_DIRECT_IO
      '.Flags and = NOT (DO_DEVICE_INITIALIZING)
   end with
   

   '创建设备 Create device
	dim pDevObj as PDEVICE_OBJECT   
   RtlInitUnicodeString(@DEVICE_NAME, My_DEVICE_NAME)
   Status = IoCreateDevice(pDriverObject,sizeof(DEVICE_EXTENSION),@DEVICE_NAME,FILE_DEVICE_UNKNOWN,FILE_DEVICE_SECURE_OPEN,FALSE,@pDevObj)
   
   if Status <> STATUS_SUCCESS THEN 
      DbgPrint(@!"Create Device Error \r\n")
      IoDeleteDevice pDevObj
      return Status
   END IF   
   

	'设备指针放入全局变量 Put the device pointer into the global variable
	g_pDeviceObject = pDevObj
   
   
   '创建事件 Create event
   dim pDevExt as PDEVICE_EXTENSION 
   RtlInitUnicodeString(@EVENT_NAME, My_EVENT_NAME)
   pDevExt = pDevObj->DeviceExtension
	pDevExt->ProcessEvent = IoCreateNotificationEvent(@EVENT_NAME,@pDevExt->hProcessHandle)
   KeClearEvent(pDevExt->ProcessEvent)

   
   '创建符号链接并关联设备 Create symbolic links and associate devices
   RtlInitUnicodeString(@LINK_NAME, My_LINK_NAME)

	Status = IoCreateSymbolicLink(@LINK_NAME,@DEVICE_NAME)
	if Status <> STATUS_SUCCESS THEN 
      DbgPrint(@!"Create Link Error \r\n")
      IoDeleteDevice pDevObj
		return Status
   end if


   '绕过PsSetCreateProcessNotifyRoutineEx坑位限制 Bypass pssetcreateprocessnotifyroutineex pit limit
   dim pLdrData as PKLDR_DATA_TABLE_ENTRY 
   pLdrData = pDriverObject->DriverSection
   pLdrData->Flags or = &H20 
   
   '注册进程监控回调 Register process monitoring callback
   Status = PsSetCreateProcessNotifyRoutineEx(@CreateProcessNotifyRoutineEx, FALSE)
   if Status <> STATUS_SUCCESS then 
      select case Status
         case STATUS_ACCESS_DENIED
            DbgPrint(@!"PsSetCreateProcessNotifyRoutineEx Hook Fail Code = STATUS_ACCESS_DENIED \r\n")
         case STATUS_INVALID_PARAMETER
            DbgPrint(@!"PsSetCreateProcessNotifyRoutineEx Hook Fail Code = STATUS_INVALID_PARAMETER \r\n")
         case else
            DbgPrint(@!"PsSetCreateProcessNotifyRoutineEx Hook Fail Code = 0x%08X \r\n")
      end select
   end if
   
   return Status
end function

Private function FBDriver_Create (byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
   dim Status as NTSTATUS = STATUS_SUCCESS
   
   DbgPrint(@!"%ws FBDriver_Create \r\n",My_DRIVE_NAME)
   Irp->IoStatus.Status = Status
   Irp->IoStatus.Information = 0
   IoCompleteRequest(Irp,IO_NO_INCREMENT)
   return Status
end function

Private sub FBDriver_Unload(byval DriverObject as PDRIVER_OBJECT)
   DbgPrint(@!"%ws FBDriver_Unload \r\n",My_DRIVE_NAME)

   '关闭事件Close event
   dim pDevExt as PDEVICE_EXTENSION 
   pDevExt = g_pDeviceObject->DeviceExtension
   KeClearEvent(pDevExt->ProcessEvent)
   ZwClose pDevExt->ProcessEvent 

'   '创建事件 Create event
'   dim pDevExt as PDEVICE_EXTENSION 
'   RtlInitUnicodeString(@EVENT_NAME, My_EVENT_NAME)
'   pDevExt = pDevObj->DeviceExtension
'	pDevExt->ProcessEvent = IoCreateNotificationEvent(@EVENT_NAME,@pDevExt->hProcessHandle)
'   KeClearEvent(pDevExt->ProcessEvent)
   '取消回调 Cancel callback
   PsSetCreateProcessNotifyRoutineEx(@CreateProcessNotifyRoutineEx, TRUE)

   '删除设备连接符号 delete device connection symbol
   dim strLink as UNICODE_STRING
   RtlInitUnicodeString(@strLink,My_LINK_NAME)
   IoDeleteSymbolicLink(@strLink)

   '删除设备对象 Delete device object
   IoDeleteDevice(DriverObject->DeviceObject) 
end sub
        
Private function FBDriver_UnsupportedFunction(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
    DbgPrint(@!"%ws FBDriver_UnsupportedFunction \r\n",My_DRIVE_NAME)
    return STATUS_NOT_SUPPORTED
end function

Private function FBDriver_Close(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
    DbgPrint(@!"%ws FBDriver_Close \r\n",My_DRIVE_NAME)
    return STATUS_SUCCESS
end function

Private function FBDriver_IoControl(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
   dim Status            as NTSTATUS = STATUS_INVALID_DEVICE_REQUEST 'STATUS_SUCCESS
   dim pIrpStack         as PIO_STACK_LOCATION
   dim pDevExt           as PDEVICE_EXTENSION
   dim Process_Callback  as My_Process_Callback PTR
   dim as ulong uIoContrlCode,uInSize,uOutSize 
   
   DbgPrint(@!"%ws FBDriver_IoControl \r\n",My_DRIVE_NAME) 
   
   pIrpStack        = IoGetCurrentIrpStackLocation(Irp)
   uInSize          = pIrpStack->Parameters.DeviceIoControl.InputBufferLength   '输入缓冲区长度
   uOutSize         = pIrpStack->Parameters.DeviceIoControl.OutputBufferLength  '输出缓冲区长度
   uIoContrlCode    = GetIoControlCode(Irp)                                     '获取I/O控制代码
	Process_Callback = Irp->AssociatedIrp.SystemBuffer                           '取得I/O缓冲区指针

   select case uIoContrlCode
      case IOCTL_PROCESS_LOCK_READ                                          '向RING3返回有事件发生的进程信息
			if uOutSize = sizeof(My_Process_Callback) then                     '输出缓冲区长度要大于返回结构大小
            pDevExt                      = g_pDeviceObject->DeviceExtension '从全局指针获取具体信息	            
				Process_Callback->hParentId  = pDevExt->hPParentId
				Process_Callback->hProcessId = pDevExt->hPProcessId
				Process_Callback->bCreate    = pDevExt->bPCreate
				Status = STATUS_SUCCESS
            
            DbgPrint(@!"%ws IoControl ProcessId=%d in:%d out:%d \r\n",My_DRIVE_NAME,Process_Callback->hProcessId,uInSize,uOutSize)
         END If
   case else
        DbgPrint(@!"%ws IoControl UnKnow IoContrlCode %d \r\n",My_DRIVE_NAME,uIoContrlCode) 
        Status = STATUS_INVALID_DEVICE_REQUEST
        uOutSize = 0         
	END SELECT
   
   Irp->IoStatus.Information = uOutSize
	Irp->IoStatus.Status = Status
	IoCompleteRequest(Irp,IO_NO_INCREMENT)
   return Status
end function

Private function FBDriver_Read(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
   DbgPrint(@!"%ws FBDriver_Read \r\n",My_DRIVE_NAME)
   return STATUS_SUCCESS
end function

Private function FBDriver_Write(byval DeviceObject as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
   DbgPrint(@!"%ws FBDriver_Write \r\n",My_DRIVE_NAME)
   return STATUS_SUCCESS
end function