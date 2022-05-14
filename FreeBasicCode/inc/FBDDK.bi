#inclib "FBDDK"
extern "C"
   Declare function RtlUnicodeStringValidateDestWorker(DestinationString as PCUNICODE_STRING,ppszDest as wchar_t PTR ptr,pcchDest as size_t PTR,pcchDestLength as size_t ptr,cchMax as size_t,dwFlags as DWORD) as NTSTATUS
   Declare function RtlUnicodeStringCat(DestinationString as PUNICODE_STRING,SourceString as PCUNICODE_STRING) as NTSTATUS
   Declare FUNCTION RtlUnicodeStringValidateSrcWorker(SourceString as PCUNICODE_STRING,ppszSrc AS wchar_t PTR PTR,cchMax AS size_t,dwFlags AS DWORD) as NTSTATUS
   Declare FUNCTION RtlUnicodeStringValidateWorker(SourceString as PCUNICODE_STRING,cchMax AS size_t,dwFlags AS DWORD) as NTSTATUS
   Declare FUNCTION IoGetCurrentIrpStackLocation(byval Irp as PIRP) as PIO_STACK_LOCATION
   
   '通过IRP获取IoContrlCode
   Declare FUNCTION GetIoControlCode(byval Irp as PIRP) AS ULONG
end extern
