declare function FBDriver_Create(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_Close(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_IoControl(byval as PDEVICE_OBJECT, byval Irp as PIRP) as NTSTATUS
declare function FBDriver_Read(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_Write(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS
declare function FBDriver_UnsupportedFunction(byval as PDEVICE_OBJECT, byval as PIRP) as NTSTATUS

declare sub FBDriver_Unload(byval as PDRIVER_OBJECT)


'ȫ�ֱ����ṹ Global variable structure
type _DEVICE_EXTENSION 
	hProcessHandle as HANDLE  '�¼�������
	ProcessEvent   as PKEVENT '���ں��ں�ͨ���¼��Ķ���ָ��
	hPParentId     as HANDLE  '�ڻص������б��������Ϣ,���ݸ��û���
	hPProcessId    as HANDLE
	bPCreate       as BOOLEAN 'true��ʾ���̱�����,false��ʾ���̱�ɾ��
end type  

type DEVICE_EXTENSION as _DEVICE_EXTENSION
type PDEVICE_EXTENSION as _DEVICE_EXTENSION ptr

'Ӧ�ò�ͨѶ�ṹ Application layer communication structure
Type My_Process_Callback
	hParentId  as HANDLE 
	hProcessId as HANDLE 
	bCreate    as BOOLEAN
end type 

'����ȫ�ֵ��豸����ָ��  define global device object pointer
Common Shared g_pDeviceObject as PDEVICE_OBJECT

static shared My_DEVICE_NAME as wstring ptr = @wstr("\Device\devMonitorProc")             '�豸��   devicename
static shared My_LINK_NAME   as wstring ptr = @wstr("\DosDevices\slinkMonitorProc")       '���������� Symbolic link name
static shared My_EVENT_NAME  as wstring ptr = @wstr("\BaseNamedObjects\MonitorProcEvent") '�¼��� Event name
static shared My_DRIVE_NAME  as wstring ptr = @wstr("FB Drive Demo:")                     'ʾ���� Demo name

'����ring3������ Define RING3 control code
#define CTRLCODE_BASE &H8000
#define MYCTRL_CODE(i) CTL_CODE(FILE_DEVICE_UNKNOWN,CTRLCODE_BASE +i,METHOD_BUFFERED,FILE_ANY_ACCESS)
#define IOCTL_PROCESS_LOCK_READ MYCTRL_CODE(1)