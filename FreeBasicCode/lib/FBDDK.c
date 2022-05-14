#include <ntifs.h>
#include <strsafe.h>

#define NTSTRSAFE_UNICODE_STRING_MAX_CCH    (0xffff / sizeof(wchar_t))  // max buffer size, in characters, for a UNICODE_STRING

typedef ULONG DWORD;

//用户可以重写NTSTRSAFE_UNICODE_STRING_MAX_CCH，但它必须始终小于(USHORT_MAX / sizeof(wchar_t))



ULONG GetIoControlCode(_In_ PIRP Irp)
{
   PIO_STACK_LOCATION pIrpStack = NULL;
   ULONG IoControlCode = 0;

   pIrpStack          = IoGetCurrentIrpStackLocation(Irp);                         //取得此IRP的I/O堆栈指针
   IoControlCode      = pIrpStack->Parameters.DeviceIoControl.IoControlCode;       //获取I/O控制代码
   return IoControlCode;
}
