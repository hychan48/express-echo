#Requires AutoHotkey v2.0
#SingleInstance
; Get VSCode and Original Position to return to after
active_id := WinGetID("A")
WinActivate(active_id)
MouseGetPos &ogxpos, &ogypos

; https://www.autohotkey.com/boards/viewtopic.php?t=72287
; https://learn.microsoft.com/en-us/windows/win32/winhttp/winhttprequest
StartTime := A_TickCount
endpoint:="http://localhost:3000?param=hi" ; url pointing to the API endpoint
; data:={"username":"demo","password":"test123"} ; key-val data to be posted

try{ ; only way to properly protect from an error here
	; createFormData(rData,rHeader,data) ; formats the data, stores in rData, header info in rHeader
	hObject:=ComObject("WinHttp.WinHttpRequest.5.1") ; create WinHttp object
	; hObject.setRequestHeader("Content-Type",rHeader) ; set content header
	hObject.open("GET",endpoint) ; open a post event to the specified endpoint
	; hObject.open("POST",endpoint) ; open a post event to the specified endpoint
	hObject.send() ; send request with data

	; you can get the response data either in raw or text format
	; raw: hObject.responseBody
	; text: hObject.responseText	
    ; tooltip hObject.responseText
    ; sleep 1000 ; works... recieves hi
    ElapsedTime := A_TickCount - StartTime
    FileAppend(endpoint ":" hObject.responseText ":" StartTime ":" ElapsedTime "`n", "log.txt")
}catch Error{
    tooltip Error
    sleep 1000
    Exit(1)
}

; Return Back to current editor
MouseMove ogxpos, ogypos
WinActivate(active_id)
Exit(0)
