
; works but i want relative path
; I_Icon = C:\Users\Jason\OneDrive\Documents\games\dota\devConsole\apple_menu.ico
I_Icon =  %A_ScriptDir%\apple.ico
IfExist, %I_Icon% 
{
  ; ToolTip, icon exists
  Menu, Tray, Icon, %I_Icon%  
}


;return
#SingleInstance, force
#UseHook
#InstallMouseHook

; todo check this out
; also hotstring and keyboard hooks
; Alt ` behaviors
!`::toggleBetweenTwoExe()
; Alt ` shift
+!`::toggleBetweenTwoExe(1)
; INTERESTING FORGOT ABOUT THIS
#!`::toggleAlwaysOnTop()
; F1::Clicking()
; F2::ReloadBlock()

; left and right? shift window to ctrl window left
+#1:: Send ^#{left}
+#2:: Send ^#{Right}


#IfWinNotActive, ahk_exe mstsc.exe
  CapsLock:: Send {Del}
; Rename Oscar Profile
#IfWinActive ahk_exe chrome.exe
  !`::toggleBetweenTwoEXEChrome()
  ; default for ctrl esc is window?
  ^esc::Send ^l ; ctrl l is clear console
  ; for dev
  ; !v::Send webetmarket@outlook.com

#IfWinActive ahk_exe sublime_text.exe
  #a::debug_function()
  #s::ReloadBlockSave()
  !s::ReloadBlockSave()
  ; !f::debug_function()
  ; s up::tooltip up
  ; s::tooltip down
  
  ; s::tooltip hold ;doesnt exist
  
  ; only need this for d2.. need a smarter way of doing this
  ; |::Suspend
  ; #r::toggleBetweenTwoClassesnTwoExe()
  ; XButton1::msgbox You pressed Mouse4
  ; XButton2::msgbox You pressed Mouse5
; git bash can't remap paste
#IfWinActive, ahk_exe mintty.exe
  !c::^Ins
  ^v::+Ins


#IfWinActive sahk_class Notepad++ 
  #s::ReloadBlock()
#If !WinActive("ahk_exe explorer.exe") 
&& !WinActive("ahk_exe mpc-hc64.exe") && !WinActive("ahk_exe vlc.exe")
!Left::Send,{Home}
!Right::Send,{End}
; !Up::Send,{PgUp}
!Up::Send,{Home}
; !Down::Send,{PgDn}
!Down::Send,{End}
; home and end... wonder if i can detect based on keyboard
; Home::Send,{Enter}
; End::Send,{Enter}
; alt / cmd + mouse5 fwd. mouse4 is back. which is mapped to XButton1 and 2
!XButton1::Send,{Enter} ; back + cmd /alt
reloadfn(){
  reload
}
moveMouse()
{
  MouseMove, 446,223
} 
  ; Not sure why this is still a function
ReloadBlock(){
  reload
}
ReloadBlockSave()
{
  ; Should be called in the developer... so it'll save First
  ; Can change this to a sublime macro... but this seems cleaner
  Send, ^s ; save first in sublime???? should sublime have it's own
  reload
}
keyPressWithRandomDelay(key)
{
  ; https://www.autohotkey.com/docs/commands/Send.htm#Raw
  random, delay, 17, 22
  random, delay2, 18, 23
  SendInput {%key% down}
  Sleep, %delay%
  SendInput {%key% up}
  Sleep, %delay2%
}
; WIth modifier... {LAlt}
keyPressWithModRandomDelay(key,kAlt="LAlt")
{


  ; https://www.autohotkey.com/docs/commands/Send.htm#Raw
  ; random, delay, 17, 22
  random, delay, 100, 110
  random, delay2, 18, 23

  SendInput {%key% down}{%kAlt% down}
  Sleep, %delay%
  SendInput {%key% up}{%kAlt% up}
  Sleep, %delay2%
}
Turbo(key="Click")
{
  ; loop counter here: todo randomize the range.
  ToolTip, Running
  Loop, 1000
  {
    ; SendInput {%key%}
    Click, WheelUp
  
  }
  ToolTip,
}
ClickingButton(key="Right")
{
  ; loop counter here: todo randomize the range.
  ToolTip, Running
  Loop
  {
    keyPressWithRandomDelay(key)
    sleep 300
    ; keyPressWithRandomDelay("x")
    ; keyPressWithRandomDelay("z")
    ; keyPressWithRandomDelay("space")
  
  }
  ToolTip,
}
Clicking()
{
  ; loop counter here: todo randomize the range.
  ToolTip, Running
  Loop, 1000
  {
    keyPressWithRandomDelay("Click")
    ; keyPressWithRandomDelay("x")
    ; keyPressWithRandomDelay("z")
    ; keyPressWithRandomDelay("space")
  
  }
  ToolTip,
}
ClickingWithDelay()
{
  ; loop counter here: todo randomize the range.
  ToolTip, Running
  Loop, 1000
  {
    keyPressWithRandomDelay("Click")
    sleep 600
    ; keyPressWithRandomDelay("x")
    ; keyPressWithRandomDelay("z")
    ; keyPressWithRandomDelay("space")
  
  }
  ToolTip,
}
KeyTimes(sKey,iCount){
  Loop, %iCount% {
    keyPressWithRandomDelay(sKey)
    Sleep 10
  }
}
clickWithKey(key){
    Loop, 1000
  {
    keyPressWithRandomDelay($%key%)
  
  }
}
; alt tabs between but doesn't cycle
; easy way is to loop backwards.. yep works
testAltTilde()
{
  ; Tilde is actually the grave key...
  ; WinGetTitle, CurrentTitle
  ; DetectHiddenText, Off
  ; WinGetActiveTitle, CurrentTitle
  WinGetClass, current_class, A
  ; https://www.autohotkey.com/docs/commands/WinGet.htm#SubCommands
  WinGet, windows, List,ahk_class %current_class%
  ; Active is always 1... so it's go to 2 is the most baSic way
  maxLen := windows - 1
  IfGreater, windows, 1
  {
    Loop %windows%
    {
      ; if (A_Index > 1)
      if (A_Index > maxLen)
      {
        id := windows%A_Index%
        WinActivate ahk_id %id%
        
        break 

        ; WinGetTitle wt, ahk_id %id%
        ; r .= A_Index . id . wt . "`n"
        
      }
      
      ; id := windows%A_Index%
      ; WinGetTitle wt, ahk_id %id%
      ; r .= A_Index . id . wt . "`n"
    }
    ; MsgBox %r%


     ; if (A_Index > 1)
      ; break
    ; id := windows%1%
    ; MsgBox, %id%
    ; WinGetTitle wt, ahk_id id
    ; MsgBox, %wt%
    ; WinActivate, ahk_id 4
  
  }
  ; debug purposes
  ; Loop %windows%
  ; ; {
  ;   id := windows%A_Index%
  ;   WinGetTitle wt, ahk_id %id%
  ;   r .= A_Index . id . wt . "`n"
  ; }
  ; MsgBox %r%  




  ; MsgBox, %CurrentTitle%
  ; MsgBox, %OutputVar%
}
toggleBetweenTwoClasses()
{
  WinGetClass, current_class, A
  WinGet, windows, List,ahk_class %current_class%
  IfGreater, windows, 1
  {
    Loop %windows%
    {
      if (A_Index > 1)    
      {
        id := windows%A_Index%
        WinActivate ahk_id %id%
        break
      }
    }
  }
}
debug_function(){
  ; WinGet test, List,ahk_class, 'PX_WINDOW_CLASS'
  ; WinSet, Alwaysontop, toggle, A
  ; there's also toggle, onn off toggle
  ; WinGet, windows, PID,A
  ; test:=windows
  ; tooltip debug_function
  ; test:= GetKeyState(JoyX,P)

  ; Input, test,T5 L4 C M E,{enter}{Esc}
  ; writeToFile("hi")
  tooltip test: %test%
  ; postToMyServer()
}
postToMyServer(data="sup"){
    endpoint:="http://localhost:3000/nintendo" ; url pointing to the API endpoint
    test:="curl -X POST -d data=""" . data .  """ " . endpoint
    ; tooltip %test%
    ; writeToFile(test)
    Run %test%

    ; runs it in the background without being annoying.
    ; Run %test%,,Hide
}
RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}
keylogger(){
  ; Visible, Timeout 5, Length4 Case{Esc} sensitive
  ; Input, test,V T5 L4 C,{enter}{Esc}
  writeToFile("hi")
  tooltip test: %test%
}
; dumps to ahk.log.. won't work inside tail...
writeToFile(sText){
  ; https://www.autohotkey.com/docs/commands/FileAppend.htm
  FileAppend,
  (
    %sText%
  ),C:\Users\jason\ahk.log
}
toggleAlwaysOnTop(){
  WinSet, Alwaysontop, toggle, A
  ; WinGet, current_id, ID,A
}
sendDirectXPython(key="/"){
  ; flask service running
  ; send_input_f4
  test:="curl http://localhost:5000" . key
  Run %test%,,Hide
}
toggleBetweenTwoEXEChrome() 
{
  WinGet, current_exe, PID, A
  WinGet, windows, List,ahk_pid %current_exe%
  IfGreater, windows, 1
  {
    Loop %windows%
    {
      if (A_Index > 1)
      {
        id := windows%A_Index%
        WinActivate ahk_id %id%
        break
      }
    }
  }
}

; ahk_exe chrome.exe
toggleBetweenTwoExe(DO_LAST=0)
{
  ; First section is to get the list of all of the titles
  ; A is active window...
  WinGet, current_name, ProcessName,A
  WinGet, current_id, ID,A
  WinGet, current_pid, PID,A
  WinGetClass, current_class, A
  ; WinGet, windows, List,ahk_class %current_class% ahk_exe %current_name%,,A
  WinGet, windows, List,ahk_pid %current_pid% ahk_class %current_class% ahk_exe %current_name%,,A


  ; Exclude doesn't work for whatever reason... so have to do this
  if(DO_LAST == 0){
    maxLen:=0
  }else{
    maxLen:=windows - 1
    ; tooltip %maxLen%
  }
  IfGreater, windows, 1
  {
    ; Loop index starts at 1... using a loop cuz easiest way to access
    Loop %windows%
    {
      ; MsgBox, %windows%
      id := windows%A_Index%
      if(current_id == id){
        if(A_Index == windows){
          ; corner case...
          tooltip corners
          lastIndex:=A_Index - 1
          id := windows%lastIndex%
          ; tooltip maxLen : %maxLen%
          WinActivate ahk_id %id%
          break
        }

      }else if(A_Index > maxLen){
        ; tooltip %A_Index% - %maxLen%
        WinActivate ahk_id %id%
        break
      }
    }
  }
}