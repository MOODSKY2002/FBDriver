'type IO_STACK_LOCATION__Parameters__Others
'	Argument1 as PVOID
'	Argument2 as PVOID
'	Argument3 as PVOID
'	Argument4 as PVOID
'end type

'type IO_STACK_LOCATION__Parameters__WMI
'	ProviderId as ULONG_PTR
'	DataPath as PVOID
'	BufferSize as ULONG
'	Buffer as PVOID
'end type

'type IO_STACK_LOCATION__Parameters__StartDevice
'	AllocatedResources as PCM_RESOURCE_LIST
'	AllocatedResourcesTranslated as PCM_RESOURCE_LIST
'end type

'type IO_STACK_LOCATION__Parameters__Power
'	SystemContext as ULONG
'	Type as POWER_STATE_TYPE
'	State as POWER_STATE
'	ShutdownType as POWER_ACTION
'end type

'type IO_STACK_LOCATION__Parameters__PowerSequence
'	PowerSequence as PPOWER_SEQUENCE
'end type

'type IO_STACK_LOCATION__Parameters__WaitWake
'	PowerState as SYSTEM_POWER_STATE
'end type

'type IO_STACK_LOCATION__Parameters__UsageNotification
'	InPath as BOOLEAN
'	Reserved(0 to 3-1) as BOOLEAN
'	Type as DEVICE_USAGE_NOTIFICATION_TYPE
'end type

'type IO_STACK_LOCATION__Parameters__QueryDeviceText
'	DeviceTextType as DEVICE_TEXT_TYPE
'	LocaleId as LCID
'end type

'type IO_STACK_LOCATION__Parameters__QueryId
'	IdType as BUS_QUERY_ID_TYPE
'end type

'type IO_STACK_LOCATION__Parameters__SetLock
'	Lock as BOOLEAN
'end type

'type IO_STACK_LOCATION__Parameters__ReadWriteConfig
'	WhichSpace as ULONG
'	Buffer as PVOID
'	Offset as ULONG
'	Length as ULONG
'end type

'type IO_STACK_LOCATION__Parameters__FRR
'	IoResourceRequirementList as PIO_RESOURCE_REQUIREMENTS_LIST
'end type

'type IO_STACK_LOCATION__Parameters__DC
'	Capabilities as PDEVICE_CAPABILITIES
'end type

'type IO_STACK_LOCATION__Parameters__QueryInterface
'	InterfaceType as GUID ptr
'	Size as USHORT
'	Version as USHORT
'	Interface as PINTERFACE
'	InterfaceSpecificData as PVOID
'end type

'type IO_STACK_LOCATION__Parameters__QDR
'	Type as DEVICE_RELATION_TYPE
'end type

'type IO_STACK_LOCATION__Parameters__Scsi
'	Srb as PSCSI_REQUEST_BLOCK
'end type

'type IO_STACK_LOCATION__Parameters__VerifyVolume
'	Vpb as PVPB
'	DeviceObject as PDEVICE_OBJECT
'end type

'type IO_STACK_LOCATION__Parameters__MountVolume
'	Vpb as PVPB
'	DeviceObject as PDEVICE_OBJECT
'end type

'type IO_STACK_LOCATION__Parameters__SetSecurity
'	SecurityInformation as SECURITY_INFORMATION
'	SecurityDescriptor as PSECURITY_DESCRIPTOR
'end type

'type IO_STACK_LOCATION__Parameters__QuerySecurity
'	SecurityInformation as SECURITY_INFORMATION
'	Length as ULONG
'end type

'type IO_STACK_LOCATION__Parameters__DeviceIoControl
'	OutputBufferLength as ULONG
'	InputBufferLength as ULONG
'	IoControlCode as ULONG
'	Type3InputBuffer as PVOID
'end type

'type IO_STACK_LOCATION__Parameters__QueryVolume
'	Length as ULONG
'	FsInformationClass as FS_INFORMATION_CLASS
'end type

'type IO_STACK_LOCATION__N_Parameters__SetFile__N_u__N__s
'	ReplaceIfExists as BOOLEAN
'	AdvanceOnly as BOOLEAN
'end type

'union IO_STACK_LOCATION__Parameters__SetFile__N_u
'	ClusterCount as ULONG
'	DeleteHandle as HANDLE
'	s as IO_STACK_LOCATION__N_Parameters__SetFile__N_u__N__s
'end union

'type IO_STACK_LOCATION__Parameters__SetFile
'	Length as ULONG
'	FileInformationClass as FILE_INFORMATION_CLASS
'	FileObject as PFILE_OBJECT
'	u as IO_STACK_LOCATION__Parameters__SetFile__N_u
'end type



'type IO_STACK_LOCATION__Parameters__QueryFile
'	Length as ULONG
'	FileInformationClass as FILE_INFORMATION_CLASS
'end type

'type IO_STACK_LOCATION__Parameters__Write
'	Length as ULONG
'	Key as ULONG
'	ByteOffset as LARGE_INTEGER
'end type

'type IO_STACK_LOCATION__Parameters__Read
'	Length as ULONG
'	Key as ULONG
'	ByteOffset as LARGE_INTEGER
'end type

'type IO_STACK_LOCATION__Parameters__Create
'	SecurityContext as PIO_SECURITY_CONTEXT
'	Options as ULONG
'	FileAttributes as USHORT
'	ShareAccess as USHORT
'	EaLength as ULONG
'end type


'union IO_STACK_LOCATION__Parameters
'	Others as IO_STACK_LOCATION__Parameters__Others
'	WMI as IO_STACK_LOCATION__Parameters__WMI
'	StartDevice as IO_STACK_LOCATION__Parameters__StartDevice
'	Power as IO_STACK_LOCATION__Parameters__Power
'	PowerSequence as IO_STACK_LOCATION__Parameters__PowerSequence
'	WaitWake as IO_STACK_LOCATION__Parameters__WaitWake
'	UsageNotification as IO_STACK_LOCATION__Parameters__UsageNotification
'	QueryDeviceText as IO_STACK_LOCATION__Parameters__QueryDeviceText
'	QueryId as IO_STACK_LOCATION__Parameters__QueryId
'	SetLock as IO_STACK_LOCATION__Parameters__SetLock
'	ReadWriteConfig as IO_STACK_LOCATION__Parameters__ReadWriteConfig
'	FilterResourceRequirements as IO_STACK_LOCATION__Parameters__FRR
'	DeviceCapabilities as IO_STACK_LOCATION__Parameters__DC
'	QueryInterface as IO_STACK_LOCATION__Parameters__QueryInterface
'	QueryDeviceRelations as IO_STACK_LOCATION__Parameters__QDR
'	Scsi as IO_STACK_LOCATION__Parameters__Scsi
'	VerifyVolume as IO_STACK_LOCATION__Parameters__VerifyVolume
'	MountVolume as IO_STACK_LOCATION__Parameters__MountVolume
'	SetSecurity as IO_STACK_LOCATION__Parameters__SetSecurity
'	QuerySecurity as IO_STACK_LOCATION__Parameters__QuerySecurity
'	DeviceIoControl as IO_STACK_LOCATION__Parameters__DeviceIoControl
'	QueryVolume as IO_STACK_LOCATION__Parameters__QueryVolume
'	SetFile as IO_STACK_LOCATION__Parameters__SetFile
'	QueryFile as IO_STACK_LOCATION__Parameters__QueryFile
'	Write as IO_STACK_LOCATION__Parameters__Write
'	Read as IO_STACK_LOCATION__Parameters__Read
'	Create as IO_STACK_LOCATION__Parameters__Create
'end union


'type _IO_STACK_LOCATION
'	MajorFunction as UCHAR
'	MinorFunction as UCHAR
'	Flags as UCHAR
'	Control as UCHAR
'	DeviceObject as PDEVICE_OBJECT
'	FileObject as PFILE_OBJECT
'	CompletionRoutine as PIO_COMPLETION_ROUTINE
'	Context as PVOID
'	Parameters as IO_STACK_LOCATION__Parameters
'end type