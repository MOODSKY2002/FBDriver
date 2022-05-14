#pragma once

#include once "crt/long.bi"
#include once "crtdefs.bi"

extern "C"

#define _INC_EXCPT
'' TODO: #pragma pack(push,_CRT_PACKING)
type EXCEPTION_DISPOSITION as long
const ExceptionContinueExecution = 0
const ExceptionContinueSearch = 1
const ExceptionNestedException = 2
const ExceptionCollidedUnwind = 3
const ExceptionExecuteHandler = 4

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))))
	'' TODO: int __cdecl _except_handler(struct _EXCEPTION_RECORD *_ExceptionRecord,void *_EstablisherFrame,struct _CONTEXT *_ContextRecord,void *_DispatcherContext);
#elseif (defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_64BIT__)) and defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))
	'' TODO: __MINGW_EXTENSION _CRTIMP int __cdecl __C_specific_handler (struct _EXCEPTION_RECORD *_ExceptionRecord, void *_EstablisherFrame, struct _CONTEXT *_ContextRecord, struct _DISPATCHER_CONTEXT *_DispatcherContext);
#endif

#if defined(__FB_DOS__) or defined(__FB_DARWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#define GetExceptionCode _exception_code
	#define exception_code _exception_code
#elseif (not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	declare function _except_handler(byval _ExceptionRecord as _EXCEPTION_RECORD ptr, byval _EstablisherFrame as any ptr, byval _ContextRecord as _CONTEXT ptr, byval _DispatcherContext as any ptr) as long
#else
	'' TODO: __MINGW_EXTENSION _CRTIMP int __attribute__((__cdecl__)) __C_specific_handler (struct _EXCEPTION_RECORD *_ExceptionRecord, void *_EstablisherFrame, struct _CONTEXT *_ContextRecord, struct _DISPATCHER_CONTEXT *_DispatcherContext);
#endif

#define GetExceptionInformation cptr(_EXCEPTION_POINTERS ptr, _exception_info)
#define exception_info cptr(_EXCEPTION_POINTERS ptr, _exception_info)

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function _exception_code() as culong
	declare function GetExceptionCode alias "_exception_code"() as culong
	declare function exception_code alias "_exception_code"() as culong
	declare function _exception_info() as any ptr
	declare function _abnormal_termination() as long
	declare function AbnormalTermination alias "_abnormal_termination"() as long
	declare function abnormal_termination alias "_abnormal_termination"() as long
#else
	#define AbnormalTermination _abnormal_termination
	#define abnormal_termination _abnormal_termination
	'' TODO: unsigned long __cdecl _exception_code(void);
	'' TODO: void *__cdecl _exception_info(void);
	'' TODO: int __cdecl _abnormal_termination(void);
#endif

const EXCEPTION_EXECUTE_HANDLER = 1
const EXCEPTION_CONTINUE_SEARCH = 0
const EXCEPTION_CONTINUE_EXECUTION = -1

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	type _PHNDLR as sub(byval as long)
#else
	'' TODO: typedef void (__cdecl * _PHNDLR)(int);
#endif

type _XCPT_ACTION
	XcptNum as culong
	SigNum as long
	XcptAction as _PHNDLR
end type

extern _XcptActTab() as _XCPT_ACTION
extern _XcptActTabCount as long
extern _XcptActTabSize as long
extern _First_FPE_Indx as long
extern _Num_FPE as long

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare function __CppXcptFilter(byval _ExceptionNum as culong, byval _ExceptionPtr as _EXCEPTION_POINTERS ptr) as long
	declare function _XcptFilter(byval _ExceptionNum as culong, byval _ExceptionPtr as _EXCEPTION_POINTERS ptr) as long
#else
	'' TODO: int __cdecl __CppXcptFilter(unsigned long _ExceptionNum,struct _EXCEPTION_POINTERS * _ExceptionPtr);
	'' TODO: int __cdecl _XcptFilter(unsigned long _ExceptionNum,struct _EXCEPTION_POINTERS * _ExceptionPtr);
#endif

type PEXCEPTION_HANDLER as function(byval as _EXCEPTION_RECORD ptr, byval as any ptr, byval as _CONTEXT ptr, byval as any ptr) as long

#if defined(__FB_DOS__) or ((not defined(__FB_64BIT__)) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)))))
	'' TODO: #define __try1(pHandler) __asm__ __volatile__ ("pushl %0;pushl %%fs:0;movl %%esp,%%fs:0;" : : "g" (pHandler));
	'' TODO: #define __except1 __asm__ __volatile__ ("movl (%%esp),%%eax;movl %%eax,%%fs:0;addl $8,%%esp;" : : : "%eax");
#elseif defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
	'' TODO: #define __try1(pHandler) __asm__ __volatile__ ("\t.l_startw:\n" "\t.seh_handler __C_specific_handler, @except\n" "\t.seh_handlerdata\n" "\t.long 1\n" "\t.rva .l_startw, .l_endw, " __MINGW64_STRINGIFY(__MINGW_USYMBOL(pHandler)) " ,.l_endw\n" "\t.text" );
	'' TODO: #define __except1 asm ("\tnop\n" "\t.l_endw: nop\n");
#else
	#define __try1(pHandler)
	#define __except1
#endif

end extern
