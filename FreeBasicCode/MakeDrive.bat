@echo off
cls

rem BAS�ļ���(��������׺) Bas file name (excluding suffix)
set drvname=FBDriverDemo

rem fbc.exe·�� fbc. Exe path
set fbcpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\fbc64.exe

rem ld.exe·�� ld. Exe path
set ldpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\bin\win64\ld.exe

rem fb��lib·�� Lib path of FB
set libpath=D:\VisualFreeBasic5.7.4\Compile\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\lib\win64

rem �Զ���lib·�� Custom lib path
set libpath2="E:\1�´���\1����ʾ��\lib"

@echo on
rem  .BAS����.O . bas generation O
%fbcpath% %drvname%.bas -c

rem .O����.SYS . o build SYS
%ldpath% %drvname%.o --subsystem=native --image-base=0x10000  --entry=DriverEntry@8  --nostdlib -shared -L %libpath% -l ntoskrnl -L %libpath2% -l FBDDK -o %drvname%.sys

pause
