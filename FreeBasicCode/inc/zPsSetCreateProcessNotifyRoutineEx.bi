'进程创建、结束回调 Process creation and end callback
Private SUB CreateProcessNotifyRoutineEx (Process as PEPROCESS,ProcessId AS HANDLE,CreateInfo AS PPS_CREATE_NOTIFY_INFO) 
   DIM pDevExt AS PDEVICE_EXTENSION

   pDevExt = g_pDeviceObject->DeviceExtension
   pDevExt->hPProcessId = ProcessId
   IF CreateInfo = NULL then 
      '进程结束 End of process
      pDevExt->bPCreate = False
      pDevExt->hPParentId = 0
      DbgPrint(@str("%ws ExitProcess ProcessId = %d \r\n"),My_DRIVE_NAME,ProcessId)
   else     
      '进程创建 Process creation
      pDevExt->hPParentId  = CreateInfo->ParentProcessId
      pDevExt->bPCreate = TRUE
      DbgPrint(@str("%ws CreateProcess ProcessId = %d \r\n"),My_DRIVE_NAME,ProcessId)
   end if

	'出发这个时间，通知应用层监听程序 Start this time and notify the application layer listener
	KeSetEvent(pDevExt->ProcessEvent,0,FALSE)
	'设置为非授信状态  Set to non credit status
	KeClearEvent(pDevExt->ProcessEvent)
end SUB