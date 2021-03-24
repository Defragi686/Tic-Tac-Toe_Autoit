#include <ButtonConstants.au3>
#include <GUIConstants.au3>
#include <MsgBoxConstants.au3>

Global $msg[9] = ["","","","X","Selecione","O","","",""]

Global $px = 0,$py = 0, $gui[13], $jogando = 0, $vez = 1, $vitoria = False, $vencedor = 0

;largura altura esquerda cima
GuiCreate("Jogo da Velha", 615, 418, -1, -1)
;Cor de fundo
GUISetBkColor(0x000000)
;Tipo de exibiçao

For $i = 0 To 8 Step 1
   if $px >= 424 Then
	  $px = 0
	  $py += 144
   EndIf

   $gui[$i]

   ;Botao Esquerda Cima Largura Altura
   $gui[$i] = GUICtrlCreateButton($msg[$i], $px, $py, 190, 129)

   GUICtrlSetFont(-1, 24,400, 0, "MS Sans Serif")
   $px += 208

Next
GUISetState(@SW_SHOW)


Inicio()

Func Inicio()
   ;Obtem qual vai ser o primeiro jogador
   while $vez = 1
		 $click = GUIGetMsg()
	  Switch $click

		 Case $gui[3]
			$vez = "X"
			ConsoleWrite("X")
		 Case $gui[5]
			$vez = "0"
			;Caso voce clique em qualquer coisa que
			;Nao seja o bolinha ou o X ele fecha o programa
		 Case $gui[0],$gui[1],$gui[2],$gui[4],$gui[6],$gui[7],$gui[8]
			Exit

		 Case $GUI_EVENT_CLOSE
			GUISetState(@SW_HIDE)
			Local $teste = MsgBox($MB_ICONWARNING + $MB_YESNO, "?", "VOCE DESEJA SAIR?")
			If $teste = 1 Or $teste = 6 Then
			   MsgBox($MB_ICONWARNING, "Exit", "A Operaçao Foi Concluida",2)
			   Exit
			EndIf
			GUISetState(@SW_SHOW)

	  EndSwitch
   WEnd
   Sleep(500)
EndFunc

Anima()

Func Anima()

   For $x = 0 To 8 Step 1
	  ;Seta cor preta no fundo dos botao apos selecionado o primeiro jogador
	  if $vitoria = False Then
		 GUICtrlSetBkColor($gui[$x],0x000000)
		 Sleep(10)
		 $msg[$x] = ""
		 GUICtrlSetData($gui[$x], "")
	  EndIf

	  Sleep(100)
   Next

EndFunc

While $jogando < 9
   ;Obtem qual botao voce clicou
   $click = GUIGetMsg()
   For $i = 0 To 8 Step 1
	  Switch $click
		 case $gui[$i]
			;Se o botao que voce clicou estiver vazio execute
			if $msg[$i] = "" Then
			   ;Contador de clicks
			   $jogando += 1
			   if $vez = "X" Then
				  ;Seta X no botao apertado
				  GUICtrlSetData($gui[$i], "X")
				  ;Muda a corda fonte para branco
				  GUICtrlSetColor($gui[$i], 0xFFFFFF)
				  ;Muda a cor de fundo para azul
				  GUICtrlSetBkColor($gui[$i], 0x000000)
				  ;Variavel responsavel pela verificaçao de ganhador
				  $msg[$i] = "X"
				  ;Apos esse if executa a vez é do Bolinha
				  $vez = "0"
				  ;Checa se o usuario ganhou
				  Checar()
			   ElseIf $vez = "0" Then
				  GUICtrlSetData($gui[$i], "0")
				  GUICtrlSetColor($gui[$i], 0xFFFFFF)
				  GUICtrlSetBkColor($gui[$i], 0x000000)
				  $msg[$i] = "O"
				  $vez = "X"
				  Checar()
			   EndIf
			EndIf

		 Case $GUI_EVENT_CLOSE
			GUISetState(@SW_HIDE)
			Local $teste = MsgBox($MB_ICONWARNING + $MB_YESNO, "?", "VOCE DESEJA SAIR?")
			If $teste = 1 Or $teste = 6 Then
			   MsgBox($MB_ICONWARNING, "Exit", "A Operaçao Foi Concluida",2)
			   Exit
			Else
			   GUISetState(@SW_SHOW)
			EndIf
	  EndSwitch
   Next
   ;Caso o numero de jogadas for igual a
   ;9 executa a funçao de VELHA e fecha o programa
   if($jogando == 9) Then
	  GUICtrlSetBkColor($gui[4],0x00FF67)
	  GUICtrlSetColor($gui[$i], 0xFFFFFF)
	  GUICtrlSetData($gui[4], "Velha!")
	  Sleep(10000)
	  Exit
   EndIf
WEnd

Func Checar()
   Select
	  ;X
	  ;Linhas
	  Case $msg[0] == "X" And $msg[1] == "X" And $msg[2] == "X"
		 GUICtrlSetBkColor($gui[0], 0x3D534E)
		 GUICtrlSetBkColor($gui[1], 0x3D534E)
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 $vencedor = 1
	  Case $msg[3] == "X" And $msg[4] == "X" And $msg[5] == "X"
		 GUICtrlSetBkColor($gui[3], 0x3D534E)
		 GUICtrlSetBkColor($gui[4], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 $vencedor = 1
	  Case $msg[6] == "X" And $msg[7] == "X" And $msg[8] == "X"
		 GUICtrlSetBkColor($gui[6], 0x3D534E)
		 GUICtrlSetBkColor($gui[7], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1
	  ;Coluna
	  Case $msg[0] == "X" And $msg[3] == "X" And $msg[6] == "X"
		 GUICtrlSetBkColor($gui[0], 0x3D534E)
		 GUICtrlSetBkColor($gui[3], 0x3D534E)
		 GUICtrlSetBkColor($gui[6], 0x3D534E)
		 $vencedor = 1
	  Case $msg[1] == "X" And $msg[4] == "X" And $msg[7] == "X"
		 GUICtrlSetBkColor($gui[1], 0x3D534E)
		 GUICtrlSetBkColor($gui[4], 0x3D534E)
		 GUICtrlSetBkColor($gui[7], 0x3D534E)
		 $vencedor = 1
	  Case $msg[2] == "X" And $msg[5] == "X" And $msg[8] == "X"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1
	  Case $msg[0] == "X" And $msg[4] == "X" And $msg[7] == "X"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1
	  Case $msg[2] == "X" And $msg[4] == "X" And $msg[6] == "X"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1
	  ;Bolinha
	  ;Linhas
	  Case $msg[0] == "O" And $msg[1] == "O" And $msg[2] == "O"
		 GUICtrlSetBkColor($gui[0], 0x3D534E)
		 GUICtrlSetBkColor($gui[1], 0x3D534E)
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 $vencedor = 2
		 Exit
	  Case $msg[3] == "O" And $msg[4] == "O" And $msg[5] == "O"
		 GUICtrlSetBkColor($gui[3], 0x3D534E)
		 GUICtrlSetBkColor($gui[4], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 $vencedor = 2
	  Case $msg[6] == "O" And $msg[7] == "O" And $msg[8] == "O"
		 GUICtrlSetBkColor($gui[6], 0x3D534E)
		 GUICtrlSetBkColor($gui[7], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 2
	  ;Coluna
	  Case $msg[0] == "O" And $msg[3] == "O" And $msg[6] == "O"
		 GUICtrlSetBkColor($gui[0], 0x3D534E)
		 GUICtrlSetBkColor($gui[3], 0x3D534E)
		 GUICtrlSetBkColor($gui[6], 0x3D534E)
		 $vencedor = 2
	  Case $msg[1] == "O" And $msg[4] == "O" And $msg[7] == "O"
		 GUICtrlSetBkColor($gui[1], 0x3D534E)
		 GUICtrlSetBkColor($gui[4], 0x3D534E)
		 GUICtrlSetBkColor($gui[7], 0x3D534E)
		 $vencedor = 2
	  Case $msg[2] == "O" And $msg[5] == "O" And $msg[8] == "O"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 2
	  Case $msg[0] == "O" And $msg[4] == "O" And $msg[7] == "O"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1
	  Case $msg[2] == "O" And $msg[4] == "O" And $msg[6] == "O"
		 GUICtrlSetBkColor($gui[2], 0x3D534E)
		 GUICtrlSetBkColor($gui[5], 0x3D534E)
		 GUICtrlSetBkColor($gui[8], 0x3D534E)
		 $vencedor = 1

   EndSelect
   ;Funçao que verifica o vencedor
   Ganhador()

EndFunc

Func Ganhador()
	  if($vencedor = 1) Then
		 GUICtrlSetBkColor($gui[4],0x000000)
		 GUICtrlSetColor($gui[$i], 0xFFFFFF)
		 GUICtrlSetData($gui[4], "X Ganhou!")
		 Sleep(10000)
		 Exit
	  ElseIf($vencedor = 2) Then
		 GUICtrlSetBkColor($gui[4],0x000000)
		 GUICtrlSetColor($gui[$i], 0xFFFFFF)
		 GUICtrlSetData($gui[4], "O Ganhou!")
		 Sleep(10000)
		 Exit
	  EndIf
EndFunc
