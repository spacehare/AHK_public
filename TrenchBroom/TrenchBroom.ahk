#Include ../general/utility.ahk
#Include techdc.ahk
#include pathcorner.ahk

#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Pixel, Client ; https://www.autohotkey.com/boards/viewtopic.php?t=77006
CoordMode, Mouse, Client
CoordMode, ToolTip, Client
#MaxThreadsPerHotkey 2
SetBatchLines, -1
; #Warn
; #InstallKeybdHook
; #UseHook, On

; "%appdata%\TrenchBroom\Preferences.json" would work with #NoEnv disabled, but not as a variable
TBpreferences := % A_AppData . "\TrenchBroom\Preferences.json"

launchKey = F11
compileKey = F12

lastEngine := 0

if WinExist("ahk_exe TrenchBroom.exe")
{
	WinActivate, ahk_exe TrenchBroom.exe
	OutputDebug, % "TrenchBroom detected"
	WinGetPos, tbX, tbY, tbW, tbH ; https://www.autohotkey.com/docs/commands/WinGetPos.htm#ExLastFound
	OutputDebug, % "X " tbX
	OutputDebug, % "Y " tbY
	OutputDebug, % "W " tbW
	OutputDebug, % "H " tbH
	searchBar := {x: tbW - 45, y: tbH - 95}
	valuesX := tbw - 50
	valuesTop := 108
	valuesBot := tbh - 116

	;ToolTip, awaga, SearchBar["x"], SearchBar.y
	;MouseMove, % tbW - 15, % tbH - 40
	; MouseMove, valuesX, valuesTop
	; sleep 1000
	; MouseMove, valuesX, valuesBot
}

#IfWinActive, ahk_exe TrenchBroom.exe ; #IfWinActive, [ WinTitle, WinText, ExcludeTitle, ExcludeText]
	; double click
	*XButton2:: Click 2
	; * is same as:
	; +XButton2:: SendInput +{Click 2}
	; ^+XButton2:: SendInput ^+{Click 2}

	Numpad3:: ShiftClick()

	; for debugging this script
	#!p:: PixelColorUnderMouse()

	; {techdc
	!m:: techdc.WriteWord()					; paste big
	^!m:: techdc.WriteWord(false)			; big
	+!m:: techdc.WriteWord(,false)			; paste small
	+^!m:: techdc.WriteWord(false,false)	; small

	^!t:: TriggerTexture()

	; path_cornera
	^!p:: PathCorner.Scratch()
	!p:: PathCorner.Iterate()
	!+p:: PathCorner.Iterate(true)

	; rename entities
	; https://www.autohotkey.com/board/topic/70338-function-wait-s-for-a-numerical-keypress/
	; https://www.autohotkey.com/docs/commands/Input.htm
	F2:: Rename()
	+F2:: RenamePC()

	; click search bar in right pane
	F4::
		MouseIOClick(searchBar.x, searchBar.y)
	Return

	; COMPILE
	!c::
		SendInput, ^{s}		; save
		Sleep, 30
		SendInput, {%compileKey%}	; Open COMPILE via Trenchbroom hotkey
		While !WinActive("Compile")
			sleep 100
		SendInput, {Left}
		Sleep, 200
		SendInput, {Enter} 	; COMPILE
	Return

	; Launch game
	!l:: LaunchI()
	!1:: Launch(0) ; COPPER LAUNCH
	!2:: Launch(1) ; ALKALINE LAUNCH
	!3:: Launch(2) ; AD LAUNCH
	!`:: Launch()
#IfWinActive

;
;
; IN GAME

#IfWinActive, ahk_exe quakespasm.exe
	; grenade jump macro
	^!P::
		Click
		Sleep, 2500
		SendInput, {Space}
	Return
	; long GL jump
	^!J::
		Click
		Sleep, 1500
		SendInput, {W down}
		Sleep, 1000
		SendInput, {Space}
		SendInput, {W up}
	Return
	; high GL jump
	^!G::
		Click
		Sleep, 1600
		SendInput, {W down}
		Sleep, 900
		SendInput, {Space}
		SendInput, {W up}
	Return
	; rocket jump
	^!R::
		SendInput, {Space}
		Sleep, 10
		Click
	Return
#IfWinActive

; open TrenchBroom preferences
!0::
	Try
	{
		p := path.File
		Run, notepad++.exe %TBpreferences%
	}
	Catch, e
	{
		Run, notepad.exe %TBpreferences%
	}
Return

#End:: ExitApp

;

ShiftClick(){ ; this sucks ass
	Sleep 10
	SendInput, {Shift down}
	KeyWait, Shift, L D
	LMB()
	Sleep 100
	SendInput, {Shift up}
	KeyWait, Shift, L
	Sleep 100
}

LMB() ; this also sucks ass
{
	sleep 100
	SendInput, {Click down}
	KeyWait, Lbutton, D L
	SendInput, {Click up}
	KeyWait, Lbutton, L
	Sleep 100
}

SendSleep(aInput, mod := "", amount := 1, aSleep := 50){
	;https://www.autohotkey.com/board/topic/148483-how-to-pass-a-key-in-a-function-parameter/
	SendInput, %mod%{%aInput% %amount%}
	OutputDebug, % mod ainput amount
	Sleep, aSleep
}

RenamePC(){
	;SendInput, ^2
	Input, userInput, L1 T6
	if userInput is integer
		Rename()
	Else
		Return
	SendInput, {right}
	SendInput, {BackSpace}
	SendInput, {%userInput%}
	SendInput, {enter}
}

Rename(){
	global
	pArrayBGR := [0xCD703E, 0xD17949]
	xy := PixelSearchArray(valuesX, valuesTop, valuesX, valuesBot, pArrayBGR)
	if ErrorLevel
		return
	MouseIOClick(xy.x, xy.y)
}

LaunchI(){
	Input, userInput, L1 T3
	if userInput is not Integer
		return
	userInput -= 1
	Launch(userInput)
}

Launch(engine := -1){
	global lastEngine
	global launchKey
	if engine = -1
		engine := lastEngine
	else
		lastEngine := engine
	SendInput, {Escape} ; Close COMPILE
	While WinActive("Compile")
		sleep 100
	SendInput, {%launchKey%} ; Open LAUNCH via Trenchbroom hotkey
	While !WinActive("Launch Engine")
		sleep 100
	SendInput, {Tab 4}
	SendInput, {Down %engine%}
	SendInput, {Enter}
}

TriggerTexture(){
	clipboard =
	SendInput, ^c
	clipwait
	reg := "(?:.+\)) \K[^\s]+"
	clipboard := RegExReplace(clipboard, reg, "trigger")
	SendInput, {x}
	SendInput, ^!v
}