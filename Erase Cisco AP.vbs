#$language = "VBScript"
#$interface = "1.0"

crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main
	crt.Screen.Send chr(13)
	crt.Screen.WaitForString "Username: "
	crt.Screen.Send "sprint" & chr(13)
	crt.Screen.WaitForString "Password: "
	crt.Screen.Send "Lc$o" & chr(13)
	crt.Sleep 10
	crt.Screen.Send "en" & chr(13)
	crt.Screen.WaitForString "Password: "
	crt.Screen.Send "Lc$oSR1" & chr(13)
	crt.Sleep 10
	crt.Screen.Send "er" & chr(9) & "st" & chr(9) & chr(13)
	crt.Screen.WaitForString "Erasing the nvram filesystem will remove all configuration files! Continue? [confirm]"
	crt.Screen.Send chr(13)
End Sub
