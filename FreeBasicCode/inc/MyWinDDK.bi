#define IOCTL_NTPROCDRV_GET_PROCINFO   CTL_CODE(FILE_DEVICE_UNKNOWN,&H800,METHOD_BUFFERED,FILE_READ_ACCESS OR FILE_WRITE_ACCESS)
#define STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY CAST(NTSTATUS,&HC0000372)
#define NtCurrentProcess() CAST(HANDLE,-1)
#define ZwCurrentProcess() NtCurrentProcess()
#define NtCurrentThread() CAST(HANDLE,-2)
#define ZwCurrentThread() NtCurrentThread()
#define ObDereferenceObject(a) ObfDereferenceObject(a)
#define NTSTRSAFE_UNICODE_STRING_MAX_CCH CAST(0xffff / sizeof(wchar_t))


const MAX_STRING_LENGTH = 512
type PS_CREATE_NOTIFY_INFO as _PS_CREATE_NOTIFY_INFO
type PPS_CREATE_NOTIFY_INFO as _PS_CREATE_NOTIFY_INFO ptr

type _KAPC_STATE
  ApcListHead(MaximumMode) as LIST_ENTRY
  Process                  as PEPROCESS
  KernelApcInProgress      as BOOLEAN
  KernelApcPending         as BOOLEAN
  UserApcPending           as BOOLEAN
end type

type KAPC_STATE as _KAPC_STATE
type PKAPC_STATE as _KAPC_STATE ptr

type _KLDR_DATA_TABLE_ENTRY
   InLoadOrderModuleList as LIST_ENTRY
   InMemoryOrderModuleList as LIST_ENTRY
   InInitializationOrderModuleList as LIST_ENTRY
   DllBase as PVOID 
   EntryPoint as PVOID 
   SizeOfImage as ulong
   FullDllName as UNICODE_STRING
   BaseDllName as UNICODE_STRING
   Flags as ulong
   LoadCount as USHORT
   TlsIndex as USHORT
   HashLinks as LIST_ENTRY
   SectionPointer as PVOID 
   CheckSum as ulong
   TimeDateStamp as ulong
   LoadedImports as PVOID 
   EntryPointActivationContext as PVOID 
   PatchInformation as PVOID
end type 
type KLDR_DATA_TABLE_ENTRY as _KLDR_DATA_TABLE_ENTRY
type PKLDR_DATA_TABLE_ENTRY as _KLDR_DATA_TABLE_ENTRY ptr

type _PS_CREATE_NOTIFY_INFO
   Size as SIZE_T
   union 
      Flags as ULONG
      type
         FileOpenNameAvailable:1 as ULONG
         IsSubsystemProcess:1    as ulong
         Reserved:30             as ulong
      end type
   end union
   ParentProcessId  as HANDLE
   CreatingThreadId AS CLIENT_ID
   FileObject       AS PFILE_OBJECT
   ImageFileName    AS PCUNICODE_STRING
   CommandLine      AS PCUNICODE_STRING
   CreationStatus   AS NTSTATUS
end type

type PcreateProcessNotifyRoutineEx as SUB (Process as PEPROCESS,ProcessId AS HANDLE,CreateInfo AS PPS_CREATE_NOTIFY_INFO)
type PCREATE_PROCESS_NOTIFY_ROUTINE_EX as PcreateProcessNotifyRoutineEx


type _NAMED_PIPE_CREATE_PARAMETERS
   NamedPipeType    as ULONG
   ReadMode         as ULONG
   CompletionMode   as ULONG
   MaximumInstances as ULONG
   InboundQuota     as ULONG
   OutboundQuota    as ULONG
   DefaultTimeout   as LARGE_INTEGER
   TimeoutSpecified as BOOLEAN
end type
type NAMED_PIPE_CREATE_PARAMETERS  as _NAMED_PIPE_CREATE_PARAMETERS
type PNAMED_PIPE_CREATE_PARAMETERS as _NAMED_PIPE_CREATE_PARAMETERS ptr

type _MAILSLOT_CREATE_PARAMETERS
   MailslotQuota      as ULONG
   MaximumMessageSize as ULONG
   ReadTimeout        as LARGE_INTEGER
   TimeoutSpecified   as BOOLEAN 
end type
type MAILSLOT_CREATE_PARAMETERS  as _MAILSLOT_CREATE_PARAMETERS
type PMAILSLOT_CREATE_PARAMETERS as _MAILSLOT_CREATE_PARAMETERS ptr

TYPE _FILE_GET_QUOTA_INFORMATION
   NextEntryOffset AS ULONG
   SidLength       AS ULONG
   Sid             AS SID
END TYPE
type FILE_GET_QUOTA_INFORMATION  as _FILE_GET_QUOTA_INFORMATION
type PFILE_GET_QUOTA_INFORMATION as _FILE_GET_QUOTA_INFORMATION ptr

TYPE _SYSTEM_POWER_STATE_CONTEXT
   union
      TYPE
         Reserved1:8 AS ULONG
         TargetSystemState:4 AS ULONG
         EffectiveSystemState:4 AS ULONG
         CurrentSystemState:4 AS ULONG
         IgnoreHibernationPath:1 AS ULONG
         PseudoTransition:1 AS ULONG
         Reserved2:10 AS ULONG
      END TYPE

      ContextAsUlong AS ULONG
   END UNION
END TYPE
type SYSTEM_POWER_STATE_CONTEXT  as _SYSTEM_POWER_STATE_CONTEXT
type PSYSTEM_POWER_STATE_CONTEXT as _SYSTEM_POWER_STATE_CONTEXT ptr




type IO_STACK_LOCATION_Parameters_Create
   SecurityContext as PIO_SECURITY_CONTEXT
   Options         as ULONG
   FileAttributes  as USHORT 'POINTER_ALIGNMENT
   ShareAccess     as USHORT
   EaLength        as ULONG  'POINTER_ALIGNMENT
end type

type IO_STACK_LOCATION_Parameters_CreatePipe
   SecurityContext as PIO_SECURITY_CONTEXT
   Options         as ULONG
   Reserved        as USHORT 'POINTER_ALIGNMENT
   ShareAccess     as USHORT
   Parameters      as PNAMED_PIPE_CREATE_PARAMETERS         
end type

type IO_STACK_LOCATION_Parameters_CreateMailslot
   SecurityContext as PIO_SECURITY_CONTEXT
   Options         as ULONG
   Reserved        as USHORT 'POINTER_ALIGNMENT
   ShareAccess     as USHORT
   Parameters      as PMAILSLOT_CREATE_PARAMETERS       
end type

type IO_STACK_LOCATION_Parameters_READ
   Length     AS ULONG
   Key        AS ULONG 'POINTER_ALIGNMENT
   ByteOffset AS LARGE_INTEGER         
end type

TYPE IO_STACK_LOCATION_Parameters_WRITE
   Length     AS ULONG
   Key        AS ULONG 'POINTER_ALIGNMENT
   ByteOffset AS LARGE_INTEGER
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryDirectory
   Length               AS ULONG
   FileName             AS PUNICODE_STRING
   FileInformationClass AS FILE_INFORMATION_CLASS
   FileIndex            AS ULONG 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_NotifyDirectory
   Length           AS ULONG
   CompletionFilter AS ULONG 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryFile
   Length               AS ULONG
   FileInformationClass AS FILE_INFORMATION_CLASS 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetFile
   Length AS ULONG
   FileInformationClass AS FILE_INFORMATION_CLASS 'POINTER_ALIGNMENT
   FileObject           AS PFILE_OBJECT
   union 
      TYPE
         ReplaceIfExists AS BOOLEAN
         AdvanceOnly     AS BOOLEAN
      END TYPE
      ClusterCount AS ULONG
      DeleteHandle AS HANDLE
   END UNION        
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryEa
   Length       AS ULONG
   EaList       AS PVOID
   EaListLength AS ULONG
   EaIndex      AS ULONG 'POINTER_ALIGNMENT 
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetEa
   Length AS ULONG
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryVolume
   Length             AS ULONG
   FsInformationClass AS FS_INFORMATION_CLASS 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetVolume
   Length             AS ULONG
   FsInformationClass AS FS_INFORMATION_CLASS 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_FileSystemControl
   OutputBufferLength AS ULONG
   InputBufferLength  AS ULONG  'POINTER_ALIGNMENT
   FsControlCode      AS ULONG  'POINTER_ALIGNMENT
   Type3InputBuffer   AS PVOID         
END TYPE

TYPE IO_STACK_LOCATION_Parameters_LockControl
   Length     AS PLARGE_INTEGER
   Key        AS ULONG     'POINTER_ALIGNMENT
   ByteOffset AS LARGE_INTEGER        
END TYPE  

TYPE IO_STACK_LOCATION_Parameters_DeviceIoControl
   OutputBufferLength AS ULONG
   InputBufferLength  AS ULONG 'POINTER_ALIGNMENT
   IoControlCode      AS ULONG 'POINTER_ALIGNMENT
   Type3InputBuffer   AS PVOID
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QuerySecurity
   SecurityInformation AS SECURITY_INFORMATION
   Length              AS ULONG 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetSecurity
   SecurityInformation AS SECURITY_INFORMATION
   SecurityDescriptor  AS PSECURITY_DESCRIPTOR
END TYPE

TYPE IO_STACK_LOCATION_Parameters_MountVolume
   Vpb          AS PVPB
   DeviceObject AS PDEVICE_OBJECT
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_VerifyVolume
   Vpb          AS PVPB
   DeviceObject AS PDEVICE_OBJECT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_Scsi
   Srb  AS PSCSI_REQUEST_BLOCK
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryQuota
   Length AS ULONG
   StartSid AS PSID
   SidList AS PFILE_GET_QUOTA_INFORMATION
   SidListLength AS ULONG
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetQuota
   Length AS ULONG
END TYPE  

TYPE IO_STACK_LOCATION_Parameters_QueryDeviceRelations
   Type AS DEVICE_RELATION_TYPE
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryInterface
   InterfaceType         AS CONST GUID ptr
   Size                  AS USHORT
   Version               AS USHORT
   Interface             AS PINTERFACE
   InterfaceSpecificData AS PVOID
END TYPE

TYPE IO_STACK_LOCATION_Parameters_DeviceCapabilities
   Capabilities AS PDEVICE_CAPABILITIES 
END TYPE  
                                 
TYPE IO_STACK_LOCATION_Parameters_FilterResourceRequirements
   IoResourceRequirementList AS PIO_RESOURCE_REQUIREMENTS_LIST
END TYPE  

TYPE IO_STACK_LOCATION_Parameters_ReadWriteConfig
   WhichSpace AS ULONG
   Buffer     AS PVOID
   Offset     AS ULONG
   Length     AS ULONG 'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_SetLock
   Lock AS BOOLEAN
END TYPE
         
TYPE IO_STACK_LOCATION_Parameters_QueryId
   IdType AS BUS_QUERY_ID_TYPE
END TYPE

TYPE IO_STACK_LOCATION_Parameters_QueryDeviceText
   DeviceTextType AS DEVICE_TEXT_TYPE
   LocaleId       AS LCID 'POINTER_ALIGNMENT
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_UsageNotification
   InPath           AS BOOLEAN
   Reserved(0 TO 2) AS BOOLEAN
   Type             AS DEVICE_USAGE_NOTIFICATION_TYPE 'POINTER_ALIGNMENT
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_WaitWake
   PowerState    AS SYSTEM_POWER_STATE
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_PowerSequence
   PowerSequence AS PPOWER_SEQUENCE
END TYPE   

TYPE IO_STACK_LOCATION_Parameters_Power
   union
      SystemContext           AS ULONG
      SystemPowerStateContext AS SYSTEM_POWER_STATE_CONTEXT
   END UNION
   Type         AS POWER_STATE_TYPE 'POINTER_ALIGNMENT
   State        AS POWER_STATE      'POINTER_ALIGNMENT
   ShutdownType AS POWER_ACTION     'POINTER_ALIGNMENT
END TYPE

TYPE IO_STACK_LOCATION_Parameters_StartDevice
   AllocatedResources           AS PCM_RESOURCE_LIST
   AllocatedResourcesTranslated AS PCM_RESOURCE_LIST
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_WMI                                'WMI Irps
   ProviderId AS ULONG_PTR
   DataPath   AS PVOID
   BufferSize AS ULONG
   Buffer     AS PVOID
END TYPE 

TYPE IO_STACK_LOCATION_Parameters_Others                             '其它的
   Argument1 AS PVOID
   Argument2 AS PVOID
   Argument3 AS PVOID
   Argument4 AS PVOID
END TYPE 

union IO_STACK_LOCATION_Parameters
   Create            as IO_STACK_LOCATION_Parameters_Create
   CreatePipe        as IO_STACK_LOCATION_Parameters_CreatePipe
   CreateMailslot    as IO_STACK_LOCATION_Parameters_CreateMailslot   
   READ              AS IO_STACK_LOCATION_Parameters_READ
   WRITE             AS IO_STACK_LOCATION_Parameters_WRITE
   QueryDirectory    AS IO_STACK_LOCATION_Parameters_QueryDirectory
   NotifyDirectory   AS IO_STACK_LOCATION_Parameters_NotifyDirectory
   QueryFile         AS IO_STACK_LOCATION_Parameters_QueryFile
   SetFile           AS IO_STACK_LOCATION_Parameters_SetFile
   QueryEa           AS IO_STACK_LOCATION_Parameters_QueryEa
   SetEa             AS IO_STACK_LOCATION_Parameters_SetEa
   QueryVolume       AS IO_STACK_LOCATION_Parameters_QueryVolume
   SetVolume         AS IO_STACK_LOCATION_Parameters_SetVolume
   FileSystemControl AS IO_STACK_LOCATION_Parameters_FileSystemControl
   LockControl       AS IO_STACK_LOCATION_Parameters_LockControl
   DeviceIoControl   AS IO_STACK_LOCATION_Parameters_DeviceIoControl
   QuerySecurity     AS IO_STACK_LOCATION_Parameters_QuerySecurity
   SetSecurity       AS IO_STACK_LOCATION_Parameters_SetSecurity
   MountVolume       AS IO_STACK_LOCATION_Parameters_MountVolume
   VerifyVolume      AS IO_STACK_LOCATION_Parameters_VerifyVolume
   Scsi              AS IO_STACK_LOCATION_Parameters_Scsi
   QueryQuota        AS IO_STACK_LOCATION_Parameters_QueryQuota
   SetQuota          AS IO_STACK_LOCATION_Parameters_SetQuota
   QueryDeviceRelations AS IO_STACK_LOCATION_Parameters_QueryDeviceRelations
   QueryInterface       AS IO_STACK_LOCATION_Parameters_QueryInterface
   DeviceCapabilities   AS IO_STACK_LOCATION_Parameters_DeviceCapabilities
   FilterResourceRequirements AS IO_STACK_LOCATION_Parameters_FilterResourceRequirements
   ReadWriteConfig      AS IO_STACK_LOCATION_Parameters_ReadWriteConfig
   SetLock              AS IO_STACK_LOCATION_Parameters_SetLock
   QueryId              AS IO_STACK_LOCATION_Parameters_QueryId
   QueryDeviceText      AS IO_STACK_LOCATION_Parameters_QueryDeviceText
   UsageNotification    AS IO_STACK_LOCATION_Parameters_UsageNotification
   WaitWake             AS IO_STACK_LOCATION_Parameters_WaitWake
   PowerSequence        AS IO_STACK_LOCATION_Parameters_PowerSequence
   Power                AS IO_STACK_LOCATION_Parameters_Power
   StartDevice          AS IO_STACK_LOCATION_Parameters_StartDevice
   WMI                  AS IO_STACK_LOCATION_Parameters_WMI
   Others               AS IO_STACK_LOCATION_Parameters_Others
END UNION

'2022-05-11 Fix By MOODSKY
type _IO_STACK_LOCATION
   MajorFunction     as UCHAR
   MinorFunction     as UCHAR
   Flags             as UCHAR
   Control           as UCHAR
   Parameters        as IO_STACK_LOCATION_Parameters
   DeviceObject      AS PDEVICE_OBJECT         '保存一个指向该设备驱动程序的设备对象的指针,如果需要，它可以被传递给完成例程。
   FileObject        AS PFILE_OBJECT           '下面的位置包含一个指向该文件对象的指针,请求。
   CompletionRoutine AS PIO_COMPLETION_ROUTINE '根据上面的标志调用下面的例程,标志字段
   Context           AS PVOID                  '保存context参数的地址,应该传递给CompletionRoutine
end type
'type IO_STACK_LOCATION  as _IO_STACK_LOCATION
'type PIO_STACK_LOCATION as _IO_STACK_LOCATION ptr



declare function PsLookupProcessByProcessId DDKAPI alias "PsLookupProcessByProcessId" (byval ProcessId as HANDLE,Process as PEPROCESS ptr) as NTSTATUS
declare function PsLookupThreadByThreadId DDKAPI alias "PsLookupThreadByThreadId" (byval UniqueThreadId as HANDLE, byval Thread as PETHREAD) as NTSTATUS
declare function PsSetCreateProcessNotifyRoutineEx DDKAPI alias "PsSetCreateProcessNotifyRoutineEx" (byval NotifyRoutine as PCREATE_PROCESS_NOTIFY_ROUTINE_EX,byval Remove as boolean ) as NTSTATUS
declare function PsGetProcessImageFileName DDKAPI alias "PsGetProcessImageFileName" (Process as PEPROCESS) as zstring ptr
declare function FsRtlIsNameInExpression DDKAPI alias "FsRtlIsNameInExpression" (byval Expression as PUNICODE_STRING,byvalsName as PUNICODE_STRING,byvalIgnoreCase as BOOLEAN,UpcaseTable as PWCH) as BOOLEAN
declare function FsRtlIsNameInUnUpcasedExpression DDKAPI alias "FsRtlIsNameInUnUpcasedExpression" (byval Expression as PUNICODE_STRING,byvalsName as PUNICODE_STRING,byvalIgnoreCase as BOOLEAN,UpcaseTable as PWCH) as BOOLEAN
declare function ZwQueryInformationProcess DDKAPI alias "ZwQueryInformationProcess" (ProcessHandle as HANDLE,ProcessInformationClass as PROCESSINFOCLASS,ProcessInformation as PVOID,ProcessInformationLength as ULONG,ReturnLength as PULONG) as NTSTATUS

declare sub RtlInitEmptyUnicodeString(byval UnicodeString as PUNICODE_STRING, byval Buffer as PWCHAR,byval BufferSize as USHORT)
declare sub KeStackAttachProcess DDKAPI alias "KeStackAttachProcess" (PROCESS as PEPROCESS, ApcState as PKAPC_STATE)
declare sub KeUnstackDetachProcess DDKAPI alias "KeUnstackDetachProcess" (ApcState as PKAPC_STATE)
declare sub IoCompleteRequest DDKAPI alias "IoCompleteRequest" (Irp as PIRP,PriorityBoost as CCHAR)

sub RtlInitEmptyUnicodeString(byval UnicodeString as PUNICODE_STRING, byval Buffer as PWCHAR,byval BufferSize as USHORT)
   UnicodeString->Length = 0
   UnicodeString->MaximumLength = BufferSize
   UnicodeString->Buffer = Buffer
end sub
