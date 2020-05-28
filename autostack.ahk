;OSISTACK V1.0
;PROGRAMA PARA HACER STACKS CON CREEP DOMINADO EN DOTA 1 RGC, CON UNA SOLA TECLA!
/*

KEYS:
S+Q=Acomodar creep para Sentinel
S+Q=Stack simple para Sentinel
S+Q=Stack doble para Sentinel
C+Q=Acomodar creep para Scourge
C+Q=Stack simple para Scourge
C+Q=Stack doble para Scourge
Ctrl+ESC=Salir del juego

*/



#SingleInstance Force
#Persistent
#NoEnv
#KeyHistory 0
SetWorkingDir %A_ScriptDir%
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0         
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
GroupAdd, WC3DOTA , Warcraft III
GroupAdd, WC3DOTA , DOTA 2
GroupAdd, WC3DOTA , Dota 2
#ifWinActive, ahk_group WC3DOTA
;DEFINICIÓN INICIAL
global maxx:=A_ScreenWidth
global maxy:=A_ScreenHeight
global DIMX:=maxx/100
global DIMY:=maxy/100
global DIR:=A_ScriptDir
global DELAY:=22
global PUNTO_SENTINEL_X:={}
global PUNTO_SENTINEL_Y:={}
global PUNTO_SCOURGE_X:={}
global PUNTO_SCOURGE_Y:={}
global sonido:=% A_ScriptDir "\ut\sonidos\tick.wav"
global DEBUG:=false
temp:=% A_ScriptDir "\ut\img\ic.ico"
Menu, Tray, Icon, %temp%
Menu, tray, add, &Ayuda, ayudaLabel
Menu, tray, add, &Configurar, Configdo
Menu, tray, add, &Delay, ChangeDelay
Menu, tray, add, &Salir, VoidLabel
Menu, Tray, Tip, osiStack!!!
Menu, Tray, NoStandard
;DEFINICIÓN INICIAL TERMINA
setear()
return
;FUNCIONES
Configdo:
	confido:=""
	while(confido==""){
		msgbox,, Configurar osiStack, Para configurar correctamente osiStack deberás ubicar el archivo "config.dota.ini" dentro de la carpeta de Warcraft III
		FileSelectFile, confido, 3, , Abrir config.dota.ini, Configuración de DotA (config.dota.ini)
	}
	sleep 200
	BlockInput, On
	Run Edit %confido%
	sleep 500
	if WinExist("ahk_class Notepad")
		WinActivate
	sleep 500
	send {alt}{right}{down 7}{enter}
	clipboard=other
	sleep 50
	send {ctrl down}v{ctrl up}{enter}{esc}
	send {home}{shift down}
	sleep 100
	send {end}{shift up}
	sleep 100
	send {backspace}
	Clipboard:="SelectAllOtherUnits = Ctrl0x20"
	sleep 50
	send {ctrl down}v{ctrl up}
	sleep 50
	send {alt}{down 4}{enter}
	sleep 100
	WinClose
	BlockInput, Off
	msgbox,, Configuración finalizada,El archivo "config.dota.ini" ha sido configurado para el correcto funcionamiento de osiStack!
return

VoidLabel:
	loop 40{
		ToolTip, Gracias por utilizar osiStack!
		sleep 1
	}
	ToolTip
	ExitApp
return

ayudaLabel:
	AnimPicFile := A_ScriptDir "\ut\img\gif.gif"
	Gui, +ToolWindow
	AGif := AddAnimatedGIF(AnimPicFile)
	GuiControl, Show, %AGif%
	Gui, Show,,Osistack explicación
return

ChangeDelay:
	Gui, New
	Gui, Add, Text, x5 y8, Delay:
	Gui, Add, Edit, x38 y5 w100 h22 vdel, %DELAY%
	Gui, Add, Button, x5 y27 w130 Default gSetDel, Aceptar
	Gui, Add, Text, x5 y50 w130, El delay debe ser un valor entre 22 y 100 (milisegundos) dependiendo del rendimiento de su equipo.
	Gui, Show, 
return


SetDel:
	esent:=true
	Gui, Submit
	if del is not integer
		esent:=false
	if(esent and del>=22 and del<=100){
		DELAY:=del
	}
	else{
		msgbox ,, Dato incorrecto, Debe introducir un número entero mayo a 22 y menor a 100. El valor del Delay sigue siendo %MINDELAY%
	}
		
return

timerSonido:
	SoundPlay, %sonido%
	sleep 10
	SoundPlay, %sonido%
	sleep 10
	SoundPlay, %sonido%
	SetTimer, timerSonido, off
return

cerrarGui:
	Gui, Submit
return

AddAnimatedGIF(imagefullpath , x="", y="", w="", h="", guiname = "1")
{
	global AG1,AG2,AG3,AG4,AG5,AG6,AG7,AG8,AG9,AG10
	static AGcount:=0, pic
	AGcount++
	html := "<html><body style='background-color: transparent' style='overflow:hidden' leftmargin='0' topmargin='0'><img src='" imagefullpath "' width=" w " height=" h " border=0 padding=0></body></html>"
	Gui, AnimGifxx:Add, Picture, vpic, %imagefullpath%
	GuiControlGet, pic, AnimGifxx:Pos
	Gui, AnimGifxx:Destroy
	Gui, %guiname%:Add, ActiveX, % (x = "" ? " " : " x" x ) . (y = "" ? " " : " y" y ) . (w = "" ? " w" picW : " w" w ) . (h = "" ? " h" picH : " h" h ) " vAG" AGcount, Shell.Explorer
	AG%AGcount%.navigate("about:blank")
	AG%AGcount%.document.write(html)
	return "AG" AGcount
}

setear(){
	WinGetPos, vposx, vposy, tx, ty, A
	asp:=tx/ty
	if(asp>=1.76 and asp<=1.78){
		PUNTO_SENTINEL_X[1]:=Floor(DIMX*6.442166)
		PUNTO_SENTINEL_Y[1]:=Floor(DIMY*88.932292)
		PUNTO_SENTINEL_X[2]:=Floor(DIMX*6.442166)
		PUNTO_SENTINEL_Y[2]:=Floor(DIMY*88.411458)
		PUNTO_SENTINEL_X[3]:=Floor(DIMX*4.831625)
		PUNTO_SENTINEL_Y[3]:=Floor(DIMY*92.057292)
		PUNTO_SENTINEL_X[4]:=Floor(DIMX*6.295754)
		PUNTO_SENTINEL_Y[4]:=Floor(DIMY*88.151042)
		PUNTO_SCOURGE_X[1]:=Floor(DIMX*14.714495)
		PUNTO_SCOURGE_Y[1]:=Floor(DIMY*89.973958)
		PUNTO_SCOURGE_X[2]:=Floor(DIMX*14.641288)
		PUNTO_SCOURGE_Y[2]:=Floor(DIMY*89.192708)
		PUNTO_SCOURGE_X[3]:=Floor(DIMX*12.445095)
		PUNTO_SCOURGE_Y[3]:=Floor(DIMY*86.197917)
		PUNTO_SCOURGE_X[4]:=Floor(DIMX*14.714494)
		PUNTO_SCOURGE_Y[4]:=Floor(DIMY*88.411458)
		PUNTO_SCOURGE_X[5]:=Floor(DIMX*14.494875)
		PUNTO_SCOURGE_Y[5]:=Floor(DIMY*89.453125)
	}else if(asp>=1.32 and asp<=1.34){
		PUNTO_SENTINEL_X[1]:=Floor(DIMX*6.375)
		PUNTO_SENTINEL_Y[1]:=Floor(DIMY*89)
		PUNTO_SENTINEL_X[2]:=Floor(DIMX*6.5)
		PUNTO_SENTINEL_Y[2]:=Floor(DIMY*88.3333333)
		PUNTO_SENTINEL_X[3]:=Floor(DIMX*4.375)
		PUNTO_SENTINEL_Y[3]:=Floor(DIMY*92)
		PUNTO_SENTINEL_X[4]:=Floor(DIMX*6.25)
		PUNTO_SENTINEL_Y[4]:=Floor(DIMY*88)
		PUNTO_SCOURGE_X[1]:=Floor(DIMX*14.5)
		PUNTO_SCOURGE_Y[1]:=Floor(DIMY*89.8333333)
		PUNTO_SCOURGE_X[2]:=Floor(DIMX*14.625)
		PUNTO_SCOURGE_Y[2]:=Floor(DIMY*89.1666666)
		PUNTO_SCOURGE_X[3]:=Floor(DIMX*12.5)
		PUNTO_SCOURGE_Y[3]:=Floor(DIMY*86.5)
		PUNTO_SCOURGE_X[4]:=Floor(DIMX*14.75)
		PUNTO_SCOURGE_Y[4]:=Floor(DIMY*88.6666667)
		PUNTO_SCOURGE_X[5]:=Floor(DIMX*14.625)
		PUNTO_SCOURGE_Y[5]:=Floor(DIMY*89.33333)
	}else if(asp>=1.58 and asp<=1.62){
		PUNTO_SENTINEL_X[1]:=Floor(DIMX*6.406250)
		PUNTO_SENTINEL_Y[1]:=Floor(DIMY*89)
		PUNTO_SENTINEL_X[2]:=Floor(DIMX*6.406250)
		PUNTO_SENTINEL_Y[2]:=Floor(DIMY*88.5)
		PUNTO_SENTINEL_X[3]:=Floor(DIMX*4.53125)
		PUNTO_SENTINEL_Y[3]:=Floor(DIMY*92)
		PUNTO_SENTINEL_X[4]:=Floor(DIMX*6.25)
		PUNTO_SENTINEL_Y[4]:=Floor(DIMY*88)
		PUNTO_SCOURGE_X[1]:=Floor(DIMX*14.375)
		PUNTO_SCOURGE_Y[1]:=Floor(DIMY*90)
		PUNTO_SCOURGE_X[2]:=Floor(DIMX*14.53125)
		PUNTO_SCOURGE_Y[2]:=Floor(DIMY*89)
		PUNTO_SCOURGE_X[3]:=Floor(DIMX*12.5)
		PUNTO_SCOURGE_Y[3]:=Floor(DIMY*86.5)
		PUNTO_SCOURGE_X[4]:=Floor(DIMX*14.6875)
		PUNTO_SCOURGE_Y[4]:=Floor(DIMY*88.75)
		PUNTO_SCOURGE_X[5]:=Floor(DIMX*14.53125)
		PUNTO_SCOURGE_Y[5]:=Floor(DIMY*89.5)
	}
}

chequear(){
	WinGetPos, vposx, vposy, tx, ty, A
	if(maxx!=tx){
		DIMX:=tx/100
		DIMY:=ty/100
	}
	setear()
}

cc(x, y){
	return x y
}

toggleControl(con, enc){
		if(enc)
			send % "{" con " down}"
		else
			send % "{" con " up}"
	sleep 40
}

enviar(con){
	send % "{" con " down}"
	sleep 1
	send % "{" con " up}"
	sleep 1
}

selectOtherUnits(){
	send {f1}{ctrl down}{space}{ctrl up}
	sleep DELAY
}

ordenarMover(posx, posy){
	selectOtherUnits()
	moverMouse(posx, posy)
	enviar("RButton")
}

moverMouse(x, y){
	MouseMove, %x%, %y%, 1
	sleep DELAY
}
 
ordernarSkill(posx, posy){
	moverMouse(posx, posy)
	enviar("q")
	enviar("lbutton")
}

hacerStack(equ, dob){
	SoundPlay, sonido[1]
	MouseGetPos, tempx, tempy
	BlockInput, On
	chequear()
	if(equ==0){
		if(dob){
		;STACK DOBLE PARA SENTINEL
			selectOtherUnits()
			ordernarSkill(PUNTO_SENTINEL_X[4], PUNTO_SENTINEL_Y[4])
			toggleControl("Shift", true)
			ordenarMover(PUNTO_SENTINEL_X[3], PUNTO_SENTINEL_Y[3])
			ordenarMover(PUNTO_SENTINEL_X[1], PUNTO_SENTINEL_Y[1])
			enviar("v")
			toggleControl("Shift", false)
		;STACK DOBLE PARA SENTINEL TERMINA
		}else{
		;STACK SIMPLE PARA SENTINEL
			ordenarMover(PUNTO_SENTINEL_X[2], PUNTO_SENTINEL_Y[2])
			toggleControl("Shift", true)
			ordenarMover(PUNTO_SENTINEL_X[3], PUNTO_SENTINEL_Y[3])
			ordenarMover(PUNTO_SENTINEL_X[1], PUNTO_SENTINEL_Y[1])
			enviar("v")
			toggleControl("Shift", false)
		;STACK SIMPLE PARA SENTINEL TERMINA
		}
	}else if(equ==1){
		if(dob){
		;STACK DOBLE PARA SCOURGE
			selectOtherUnits()
			ordenarMover(PUNTO_SCOURGE_X[5], PUNTO_SCOURGE_Y[5])
			toggleControl("Shift", true)
			ordernarSkill(PUNTO_SCOURGE_X[4], PUNTO_SCOURGE_Y[4])
			ordenarMover(PUNTO_SCOURGE_X[3], PUNTO_SCOURGE_Y[3])
			ordenarMover(PUNTO_SCOURGE_X[1], PUNTO_SCOURGE_Y[1])
			enviar("v")
			toggleControl("Shift", false)
		;STACK DOBLE PARA SCOURGE TERMINA
		}else{
		;STACK SIMPLE PARA SCOURGE
			ordenarMover(PUNTO_SCOURGE_X[2], PUNTO_SCOURGE_Y[2])
			toggleControl("Shift", true)
			ordenarMover(PUNTO_SCOURGE_X[3], PUNTO_SCOURGE_Y[3])
			ordenarMover(PUNTO_SCOURGE_X[1], PUNTO_SCOURGE_Y[1])
			enviar("v")
			toggleControl("Shift", false)
		;STACK SIMPLE PARA SCOURGE TERMINA
		}
	}
	enviar("f1")
	MouseMove, %tempx%, %tempy%, 1
	SetTimer, timerSonido, 55000
	sleep DELAY
	BlockInput, Off
}

posicionarCreep(equ){
	MouseGetPos, tempx, tempy
	BlockInput, On
	chequear()
	if(equ==0){
			ordenarMover(PUNTO_SENTINEL_X[3], PUNTO_SENTINEL_Y[3])
			ordenarMover(PUNTO_SENTINEL_X[1], PUNTO_SENTINEL_Y[1])
	}else if(equ==1){
			ordenarMover(PUNTO_SCOURGE_X[3], PUNTO_SCOURGE_Y[3])
			ordenarMover(PUNTO_SCOURGE_X[1], PUNTO_SCOURGE_Y[1])
	}
	MouseMove, %tempx%, %tempy%, 1
	enviar("f1")
	sleep DELAY
	BlockInput, Off
}
;FUNCIONES TERMINA

;KEYS
~Numpad3::
	posicionarCreep(0)
return
~Numpad6::
	hacerStack(0, false)
return
~Numpad9::
	hacerStack(0, true)
return
~^Numpad3::
	posicionarCreep(1)
return
~^Numpad6::
	hacerStack(1, false)
return
~^Numpad9::
	hacerStack(1, true)
return


~Left::
if(DEBUG){
	MouseGetPos, tx, ty
	tx:=tx-1
	if(tx>=0)
		MouseMove, %tx%, %ty%
	else
		tx:=0
	send {Rbutton}
}
return

~Right::

if(DEBUG){
	tx:=tx+1
	if(tx<=1366)
		MouseMove, %tx%, %ty%
	else
		tx:=1366
	send {Rbutton}
}
return

~Up::
if(DEBUG){
	ty:=ty-1
	if(ty>=0)
		MouseMove, %tx%, %ty%
	else
		ty:=0
	send {Rbutton}
}
return

~Down::
if(DEBUG){
	ty:=ty+1
	if(ty<=768)
		MouseMove, %tx%, %ty%
	else
		ty:=768
	send {Rbutton}
}
return

~p::
if(DEBUG){
	MouseGetPos, tx, ty
	Clipboard=% "x=" tx "y=" ty
}
return

~c::
if(DEBUG){
	InputBox, asd
	asd:=asd*100/640
	Clipboard:=asd
}
return

^esc::
	ExitApp
return

;KEYS FINALIZA