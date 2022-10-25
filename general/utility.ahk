global mX, mY := 0

class Point
{
	__New(ax, ay)
	{
		if (ax is not number) or (ay is not number)
			Throw, "Point input is not number"
		this.x := ax
		this.y := ay
	}
}

MouseIn()
{
	MouseGetPos, mX, mY
	BlockInput, MouseMove
}

MouseOut()
{
	mouseMove, mX, mY
	BlockInput, MouseMoveOff
}

MouseIOClick(x, y)
{
	MouseIn()
	MouseMove, x, y
	Click
	MouseOut()
}

PixelColorUnderMouse(RGB := false)
{
	local
	MouseGetPos, mX, mY
	PixelGetColor, pColor, mX, mY

	OutputDebug, % "BGR " pColor
	OutputDebug, % "RGB " SwapRGB(pColor)

	if !RGB
		return pColor
	else
		return SwapRGB(pColor)
}

PixelSearchArray(x1, y1, x2, y2, colorArray, RGB := false)
{
	for index, pColor in colorArray
	{
		if !RGB
			PixelSearch, oX, oY, x1, y1, x2, y2, pColor,, fast
		else
			PixelSearch, oX, oY, x1, y1, x2, y2, pColor,, fast RGB
		if !ErrorLevel
		{
			xy := {x: oX, y: oY}
			return xy
		}
	}
	return
}

SwapRGB(icolor){
	a := SubStr(icolor, 3, 2)
	b := SubStr(icolor, 5, 2)
	c := SubStr(icolor, 7, 2)
	return % "0x" c b a
}

; - - - -
; https://www.autohotkey.com/docs/commands/_If.htm#ExVolume

MouseIsOver(WinTitle) {
	MouseGetPos,,, Win
	return WinExist(WinTitle . " ahk_id " . Win)
}

; #If MouseIsOver("ahk_class Shell_TrayWnd")
; WheelUp::Send {Volume_Up}
; WheelDown::Send {Volume_Down}

; MouseIsOver(WinTitle) {
; 	MouseGetPos,,, Win
; 	return WinExist(WinTitle . " ahk_id " . Win)
; }
; #If
