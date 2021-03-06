' WINFBE FORM
' WINFBE VERSION 1.9.1
' LOCKCONTROLS=False
' SNAPLINES=True
' WINFBE FORM_START
' WINFBE CONTROL_START Form
'   PROPERTIES_START
'     PROP_NAME=Name
'     PROP_VALUE=Form1
'     PROP_NAME=Left
'     PROP_VALUE=10
'     PROP_NAME=Top
'     PROP_VALUE=10
'     PROP_NAME=Width
'     PROP_VALUE=500
'     PROP_NAME=Height
'     PROP_VALUE=300
'     PROP_NAME=Text
'     PROP_VALUE=Form1
'     PROP_NAME=WindowState
'     PROP_VALUE=FormWindowState.Normal
'     PROP_NAME=StartPosition
'     PROP_VALUE=FormStartPosition.Manual
'     PROP_NAME=BorderStyle
'     PROP_VALUE=FormBorderStyle.Sizable
'     PROP_NAME=MinimizeBox
'     PROP_VALUE=True
'     PROP_NAME=MaximizeBox
'     PROP_VALUE=True
'     PROP_NAME=ControlBox
'     PROP_VALUE=True
'     PROP_NAME=Enabled
'     PROP_VALUE=True
'     PROP_NAME=Visible
'     PROP_VALUE=True
'     PROP_NAME=BackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=AcceptButton
'     PROP_VALUE=
'     PROP_NAME=AllowDrop
'     PROP_VALUE=False
'     PROP_NAME=KeyPreview
'     PROP_VALUE=False
'     PROP_NAME=CancelButton
'     PROP_VALUE=
'     PROP_NAME=Icon
'     PROP_VALUE=
'     PROP_NAME=Locked
'     PROP_VALUE=False
'     PROP_NAME=MaximumHeight
'     PROP_VALUE=0
'     PROP_NAME=MaximumWidth
'     PROP_VALUE=0
'     PROP_NAME=MinimumHeight
'     PROP_VALUE=0
'     PROP_NAME=MinimumWidth
'     PROP_VALUE=0
'     PROP_NAME=Tag
'     PROP_VALUE=
'   PROPERTIES_END
'   EVENTS_START
'   EVENTS_END
' WINFBE CONTROL_END
' WINFBE CONTROL_START Button
'   PROPERTIES_START
'     PROP_NAME=Name
'     PROP_VALUE=Button1
'     PROP_NAME=Left
'     PROP_VALUE=20
'     PROP_NAME=Top
'     PROP_VALUE=19
'     PROP_NAME=Width
'     PROP_VALUE=84
'     PROP_NAME=Height
'     PROP_VALUE=52
'     PROP_NAME=BackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=BackColorDown
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=BackColorHot
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=AllowDrop
'     PROP_VALUE=False
'     PROP_NAME=Font
'     PROP_VALUE=Segoe UI,9,400,0,0,0,1
'     PROP_NAME=TextForeColor
'     PROP_VALUE=SYSTEM|ControlText
'     PROP_NAME=TextBackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=TextForeColorDown
'     PROP_VALUE=SYSTEM|ControlText
'     PROP_NAME=TextBackColorDown
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=Image
'     PROP_VALUE=
'     PROP_NAME=ImageWidth
'     PROP_VALUE=16
'     PROP_NAME=ImageHeight
'     PROP_VALUE=16
'     PROP_NAME=ImageMargin
'     PROP_VALUE=4
'     PROP_NAME=ImageHighDPI
'     PROP_VALUE=True
'     PROP_NAME=Text
'     PROP_VALUE=Button1
'     PROP_NAME=TextAlign
'     PROP_VALUE=ButtonAlignment.MiddleCenter
'     PROP_NAME=TextMargin
'     PROP_VALUE=4
'     PROP_NAME=UseMnemonic
'     PROP_VALUE=True
'     PROP_NAME=ThemeSupport
'     PROP_VALUE=True
'     PROP_NAME=ToggleMode
'     PROP_VALUE=False
'     PROP_NAME=Enabled
'     PROP_VALUE=True
'     PROP_NAME=TabIndex
'     PROP_VALUE=1
'     PROP_NAME=TabStop
'     PROP_VALUE=True
'     PROP_NAME=Locked
'     PROP_VALUE=False
'     PROP_NAME=Tag
'     PROP_VALUE=
'     PROP_NAME=Visible
'     PROP_VALUE=True
'   PROPERTIES_END
'   EVENTS_START
'     EVENT_NAME=Click
'   EVENTS_END
' WINFBE CONTROL_END
' WINFBE FORM_END
' WINFBE_CODEGEN_START
#include once "WinFormsX\WinFormsX.bi"
Declare Function Form1_Button1_Click( ByRef sender As wfxButton, ByRef e As EventArgs ) As LRESULT

type Form1Type extends wfxForm
   private:
      temp as byte
   public:
      declare constructor
      ' Controls
      Button1 As wfxButton
end type

constructor Form1Type
   dim as long nClientOffset

   this.Text = "Form1"
   this.SetBounds(10,10,500,300)
   this.Button1.Parent = @this
   this.Button1.Text = "Button1"
   this.Button1.SetBounds(20,19-nClientOffset,84,52)
   this.Button1.OnClick = @Form1_Button1_Click
   this.Controls.Add(ControlType.Button, @this.Button1)
   Application.Forms.Add(ControlType.Form, @this)
end constructor

dim shared Form1 as Form1Type
' WINFBE_CODEGEN_END
static shared My_EVENT_NAME  as wstring ptr = @wstr("Global\MonitorProcEvent") '事件名
'static shared My_EVENT_NAME  as wstring ptr = @wstr("MonitorProcEvent") '事件名

#define CTRLCODE_BASE &H8000
#define MYCTRL_CODE(i) CTL_CODE(FILE_DEVICE_UNKNOWN,CTRLCODE_BASE +i,METHOD_BUFFERED,FILE_ANY_ACCESS)
#define IOCTL_PROCESS_LOCK_READ MYCTRL_CODE(1)
#define IOCTL_PROCESS_LOCK_READ     MYCTRL_CODE(1)

#include once "win\winioctl.bi"
'应用层通讯结构
Type My_Process_Callback
	hParentId  as HANDLE 
	hProcessId as HANDLE 
	bCreate    as BOOLEAN
end type  

''  Remove the following Application.Run code if it used elsewhere in your application.
Application.Run(Form1)

''
Function SendMsg(ByVal buf As String) As Long '调试输出的函数
    Dim Cdt As COPYDATASTRUCT
    Static ghDlg As HWND
    
    If IsWindow(ghDlg)=0 Then 
        ghDlg=FindWindow("调试输出 v3.0","调试输出 v3.0")
        If ghDlg = 0 Then ghDlg=FindWindow(ByVal 0,"调试输出 v3.0")        
    End If
    
    If ghDlg>0 And Len(buf)>0 Then
        buf="[" & GetCurrentProcessId & "] " & GetCurrentThreadId & ": " & buf 
        Cdt.dwData = 1001              '服务编号
        Cdt.cbdata = Len(buf)             '数据大小
        Cdt.lpData = StrPtr(buf)                '数据地址
        SendMessage ghDlg, WM_COPYDATA, 0, @Cdt
    End If
    
    function = 1
End Function

Function Form1_Button1_Click( ByRef sender As wfxButton, ByRef e As EventArgs ) As LRESULT
   dim szLinkName as string
   dim hDriver as HANDLE
   DIM sz as string
   'dim hProcessEvent as Boolean
   sendmsg "code:" & IOCTL_PROCESS_LOCK_READ
   szLinkName = "slinkMonitorProc"
   sz = "\\.\" & szLinkName
   hDriver = CreateFile(sz,GENERIC_READ OR GENERIC_WRITE,0,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL) 
   if hDriver = INVALID_HANDLE_VALUE then 
      messagebox 0,"open driver error!","",0
      exit function
   end if
   
   '打开时间内核对象，等待驱动程序通知
   dim hProcessEvent as HANDLE
   hProcessEvent = OpenEventW(SYNCHRONIZE,FALSE,My_EVENT_NAME)
   if hProcessEvent = null then messagebox 0,"open event error!","",0
   
   dim as My_Process_Callback callbackinfo,callbacktemp
   sendmsg "callbackinfo: " & @callbackinfo & " size:" & sizeof(callbackinfo)
   
   dim wRet as DWORD
   wRet = WaitForSingleObject(hProcessEvent,INFINITE)
   while wRet = WAIT_OBJECT_0
       'sendmsg "here message coming!!"
       
      '向驱动发送控制代码
		dim nBytesReturn as DWORD
      dim Ret as WINBOOL
      dim snu(0 to 2) as byte
      'snu=123
      callbackinfo.hProcessId = 9999
		Ret = DeviceIoControl(hDriver,IOCTL_PROCESS_LOCK_READ,null,0,@callbackinfo,sizeof(callbackinfo),@nBytesReturn,NULL)

      sendmsg "recive buffer length bBytesReturn=" & nBytesReturn
      if Ret then 
               sendmsg "before recive callbackinfo->hProcesssId:" & callbackinfo.hProcessId
         with callbackinfo  
            if callbackinfo.hParentId <> callbacktemp.hParentId or callbackinfo.hProcessId <> callbacktemp.hProcessId or callbackinfo.bCreate <> callbacktemp.bCreate then 
               if callbackinfo.bCreate then 
                  sendmsg "create process:" & callbackinfo.hParentId & "->" & callbackinfo.hProcessId
               else
                  sendmsg "create Exit:" & callbackinfo.hProcessId
               end if 
            end if
         end with
         callbacktemp = callbackinfo
      else
         sendmsg "Get DriverMsg Error!"   
      end if
      
      wRet = WaitForSingleObject(hProcessEvent,INFINITE)
   wend
   select case wRet 
   case WAIT_TIMEOUT
         sendmsg "WAIT_TIMEOUT:" & getlasterror
   case WAIT_FAILED
      sendmsg "WAIT_FAILED:" & getlasterror
   case WAIT_ABANDONED
      sendmsg "WAIT_ABANDONED:" & getlasterror
   case else
      sendmsg "waitunknow:" & getlasterror
   end select
 
   CloseHandle(hDriver)
   sendmsg "work is over"
   Function = 0
End Function

