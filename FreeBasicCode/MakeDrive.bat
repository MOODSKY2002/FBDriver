@echo off
cls

rem BAS文件名(不包括后缀) Bas file name (excluding suffix)
set drvname=FBDriverDemo

rem fbc.exe路径 fbc. Exe path
set fbcpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\fbc64.exe

rem ld.exe路径 ld. Exe path
set ldpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\bin\win64\ld.exe

rem fb的lib路径 Lib path of FB
set libpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\lib\win64

rem 自定义lib路径 Custom lib path
set libpath2="E:\1新代码\1驱动示例\lib"

@echo on
rem  .BAS生成.O . bas generation O
%fbcpath% %drvname%.bas -c

rem .O生成.SYS . o build SYS
%ldpath% %drvname%.o --subsystem=native --image-base=0x10000  --entry=DriverEntry@8  --nostdlib -shared -L %libpath% -l ntoskrnl -L %libpath2% -l FBDDK -o %drvname%.sys

pause
