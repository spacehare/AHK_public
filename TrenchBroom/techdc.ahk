; load .map brush templates for techdc uppercase A
FileRead, fileOutput, brushes\techdc_large_A.txt
techdc.templateAlarge := fileOutput
FileRead, fileOutput, brushes\techdc_small_A.txt
techdc.templateAsmall := fileOutput

Class techdc {
	class Character {
		__New(ax, ay) {
			this.x := ax
			this.y := ay
		}
	}

	static templateAlarge := "ERROR"
	static templateAsmall := "ERROR"

	static small := 32
	static large := 64

	; upper
	static A := New techdc.Character(0, 0)
	static B := New techdc.Character(1, 0)
	static C := New techdc.Character(2, 0)
	static D := New techdc.Character(3, 0)
	static E := New techdc.Character(4, 0)
	static F := New techdc.Character(5, 0)
	static G := New techdc.Character(6, 0)
	static H := New techdc.Character(7, 0)

	static I := New techdc.Character(0, 1)
	static J := New techdc.Character(1, 1)
	static K := New techdc.Character(2, 1)
	static L := New techdc.Character(3, 1)
	static M := New techdc.Character(4, 1)
	static N := New techdc.Character(5, 1)
	static O := New techdc.Character(6, 1)
	static P := New techdc.Character(7, 1)

	static Q := New techdc.Character(0, 2)
	static R := New techdc.Character(1, 2)
	static S := New techdc.Character(2, 2)
	static T := New techdc.Character(3, 2)
	static U := New techdc.Character(4, 2)
	static V := New techdc.Character(5, 2)
	static W := New techdc.Character(6, 2)
	static X := New techdc.Character(7, 2)

	static Y := New techdc.Character(0, 3)
	static Z := New techdc.Character(1, 3)

	; lower
	static lA := New techdc.Character(0, 4)
	static lB := New techdc.Character(1, 4)
	static lC := New techdc.Character(2, 4)
	static lD := New techdc.Character(3, 4)
	static lE := New techdc.Character(4, 4)
	static lF := New techdc.Character(5, 4)
	static lG := New techdc.Character(6, 4)
	static lH := New techdc.Character(7, 4)

	static lI := New techdc.Character(0, 5)
	static lJ := New techdc.Character(1, 5)
	static lK := New techdc.Character(2, 5)
	static lL := New techdc.Character(3, 5)
	static lM := New techdc.Character(4, 5)
	static lN := New techdc.Character(5, 5)
	static lO := New techdc.Character(6, 5)
	static lP := New techdc.Character(7, 5)

	static lQ := New techdc.Character(0, 6)
	static lR := New techdc.Character(1, 6)
	static lS := New techdc.Character(2, 6)
	static lT := New techdc.Character(3, 6)
	static lU := New techdc.Character(4, 6)
	static lV := New techdc.Character(5, 6)
	static lW := New techdc.Character(6, 6)
	static lX := New techdc.Character(7, 6)

	static lY := New techdc.Character(0, 7)
	static lZ := New techdc.Character(1, 7)

	; digits
	static n0 := New techdc.Character(2, 3)
	static n1 := New techdc.Character(3, 3)
	static n2 := New techdc.Character(4, 3)
	static n3 := New techdc.Character(5, 3)
	static n4 := New techdc.Character(6, 3)
	static n5 := New techdc.Character(7, 3)

	static n6 := New techdc.Character(2, 7)
	static n7 := New techdc.Character(3, 7)
	static n8 := New techdc.Character(4, 7)
	static n9 := New techdc.Character(5, 7)

	; symbols
	static sDash := New techdc.Character(6, 7)
	static sHash := New techdc.Character(7, 7)

	WriteWord(paste := true, large := true)
	{
		InputBox, Sign
		If ErrorLevel or Sign = ""
			return
		OutputDebug, % Sign

		Sign := StrSplit(Sign)

		rXOffset := "\{techdc\d_\w* \[(?:-?\d*\.?\d* ){4}\K.+?(?= \])"
		rYOffset := "\{techdc\d_\w* \[(?:-?\d*\.?\d* ){4}\K.+? \] \[ (?:-?\d*\.?\d* ){3}\K.+?(?= )"

		size := large ? this.large : this.small
		template := large ? this.templateAlarge : this.templateAsmall
		brushGroup := "{""classname"" ""func_detail_illusionary"""

		for index, char in Sign
		{
			if char = % " "
			{
				index++
				continue
			}

			; initialize / reset
			i := 1
			brush := template

			loop
			{
				; move verts on X axis
				reg := % "sS)(?:.*?\( (\K-?\d+)){" i "}"
				RegExMatch(template, reg, value)
				value += size * (index - 1)
				brush := RegExReplace(brush, reg, value)
				i++
			} until i > 18

			; adjust UV to get correct character

			; find character
			n := "" ; if this is not present, first lowercase letter makes rest of letters lowercase
			if char is lower
				n := "l"
			else if char is digit
				n := "n"
			else if char = `-
				char := "sDash"
			else if char = `#
				char := "sHash"

			; grab character's XY coords
			tchar := techdc[n . char]
			OutputDebug, % "picked " char " " tchar.x " " tchar.y

			; grab current UV offset
			; RegExMatch(brush, rXOffset, texOffsetX)
			; RegExMatch(brush, rYOffset, texOffsetY)

			; translate UV, correcting for position in word
			x1 := (tchar.x - (index - 1)) * size
			y1 := tchar.y * size

			brush := RegExReplace(brush, rXOffset, x1)
			brush := RegExReplace(brush, rYOffset, y1)

			brushGroup .= brush
		}

		brushGroup .= "}"
		clipboard := brushGroup
		ClipWait
		SoundPlay, ..\sfx\combine_button1.wav
		if paste
			SendInput, ^v
	}

	PickOne(character, large := true)
	{
		size := large ? this.large : this.small
		template := large ? this.templateAlarge : this.templateAsmall
		OutputDebug, % "size: " size
		if character is lower
			n := "l"
		else if character is digit ; DONT PUT () AROUND
			n := "n"
		else if character = `-
			character := "sDash"
		else if character = `#
			character := "sHash"
		tcharacter := techdc[n . character]
		OutputDebug, % "picked " character " " tcharacter.x " " tcharacter.y
		x := % tcharacter.x
		y := % tcharacter.y
		xOff := x * size
		yOff := y * size
		OutputDebug, % "off: " xOff " " yOff
		; TODO: grab X trans for making full words

		rXOffset := "\{techdc\d_\w* \[(?:-?\d*\.?\d* ){4}\K.+?(?= \])"
		rYOffset := "\{techdc\d_\w* \[(?:-?\d*\.?\d* ){4}\K.+? \] \[ (?:-?\d*\.?\d* ){3}\K.+?(?= )"

		; x offset
		out := RegExReplace(template, rXOffset, xOff)

		; y offset
		out := RegExReplace(out, rYOffset, yOff)
		;OutputDebug, % out
		clipboard := out
	}

	WriteOne()
	{
		local
		Input, AnyKey, L1 T3
		KeyWait, %AnyKey%
		this.PickOne(AnyKey)
		SendInput, ^v
	}
}