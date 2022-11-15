FileRead, fileOutput, brushes\path_corner.txt
PathCorner.Template := fileOutput

class PathCorner{
	static Template := "ERROR"

	static rTargetname := "(?<=""targetname"" "").+(?="")"
	static rTarget := "(?<=""target"" "").+(?="")"

	static rTargetnameNumber := """targetname"" ""\D*\K\d+"
	static rTargetNumber := """target"" ""\D*\K\d+"

	Scratch(){
		Clipboard := this.Template
		SendInput, ^v
	}

	Iterate(loop := false, copy := true){
		if copy
		{
			Clipboard = ; this is EXTREMELY important, otherwise pasting doesnt work properly
			SendInput, ^c
			ClipWait, 1
		}
		if ErrorLevel or not InStr(Clipboard, "path_corner")
			return

		RegExMatch(Clipboard, this.rTargetnameNumber, targetnameNumber)
		RegExMatch(Clipboard, this.rTargetNumber, targetNumber)
		targetnameNumber++
		targetNumber++
		Clipboard := RegExReplace(Clipboard, this.rTargetnameNumber, targetnameNumber)
		Clipboard := RegExReplace(Clipboard, this.rTargetNumber, loop ? 0 : targetNumber)
		SendInput, ^v
	}
}