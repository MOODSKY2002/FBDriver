declare function FBDriver_Create(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_Close(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_IoControl(byval as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
declare function FBDriver_Read(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_Write(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_UnsupportedFunction(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS

declare sub FBDriver_Unload(byval as PDRIVER_OBJECT)


'全局变量结构 Global variable structure
type _DEVICE_EXTENSION 
	hProcessHandle as HANDLE  '事件对象句柄
	ProcessEvent   as PKEVENT '用于和内核通信事件的对象指针
	hPParentId     as HANDLE  '在回调函数中保存进程信息,传递给用户层
	hPProcessId    as HANDLE
	bPCreate       as BOOLEAN 'true表示进程被创建,false表示进程被删除
end type  

type DEVICE_EXTENSION as _DEVICE_EXTENSION
type PDEVICE_EXTENSION as _DEVICE_EXTENSION ptr

'应用层通讯结构 Application layer communication structure
Type My_Process_Callback
	hParentId  as HANDLE 
	hProcessId as HANDLE 
	bCreate    as BOOLEAN
end type 

'定义全局的设备对象指针  define global device object pointer
Common Shared g_pDeviceObject as PDEVICE_OBJECT

static shared My_DEVICE_NAME as wstring ptr = @wstr("\Device\devMonitorProc")             '设备名   devicename
static shared My_LINK_NAME   as wstring ptr = @wstr("\DosDevices\slinkMonitorProc")       '符号链接名 Symbolic link name
static shared My_EVENT_NAME  as wstring ptr = @wstr("\BaseNamedObjects\MonitorProcEvent") '事件名 Event name
static shared My_DRIVE_NAME  as wstring ptr = @wstr("FB Drive Demo:")                     '示例名 Demo name

'定义ring3控制码 Define RING3 control code
#define CTRLCODE_BASE &H8000
#define MYCTRL_CODE(i) CTL_CODE(FILE_DEVICE_UNKNOWN,CTRLCODE_BASE +i,METHOD_BUFFERED,FILE_ANY_ACCESS)
#define IOCTL_PROCESS_LOCK_READ MYCTRL_CODE(1)