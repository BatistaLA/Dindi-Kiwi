extends Node2D

onready var menu2p = get_node("menuPausa_p2")
onready var menu1p_dindi = get_node("menuPausa_p1_dindi")
onready var menu1p_kiwi = get_node("menuPausa_p1_kiwi")
onready var ui_dindi = get_node("ui_dindi")
onready var ui_kiwi = get_node("ui_kiwi")

# Estados:
# true - Nao mostra tela
# false - Mostra tela
#var estado = false
var contador = 1

# Escolha MENU
# 1 - p1 dindi
# 2 - p1 kiwi
# 3 - p2
var escolhaMenu = 0

# Chaves Animacao
onready var chaveAmarelaD2 = $menuPausa_p2/ChaveDindi/ChaveAmarela
onready var chaveRoxaD2 = $menuPausa_p2/ChaveDindi/ChaveRoxa
onready var chaveAmarelaD1 = $menuPausa_p1_dindi/ChaveDindi/ChaveAmarela
onready var chaveRoxaD1 = $menuPausa_p1_dindi/ChaveDindi/ChaveRoxa

onready var chaveAmarelaK2 = $menuPausa_p2/ChaveKiwi/ChaveAmarela
onready var chaveRoxaK2 = $menuPausa_p2/ChaveKiwi/ChaveRoxa
onready var chaveAmarelaK1 = $menuPausa_p1_kiwi/ChaveKiwi/ChaveAmarela
onready var chaveRoxaK1 = $menuPausa_p1_kiwi/ChaveKiwi/ChaveRoxa

func _ready():
	# Isso vai ocultar todos os nos
	menu2p.hide()
	menu1p_dindi.hide()
	menu1p_kiwi.hide()
	ui_dindi.hide()
	ui_kiwi.hide()
	animacaoChaves()
	
##################### PROCESSO FISICO - MAIN LOOP ########################
func _physics_process(delta):
	# Essa funcao define o menu que sera mostrado
	escolha_menu()
	valoresMenu()
	animacaoChaves()
	
	if Input.is_action_just_pressed("menu"):
		contador = contador + 1
		
	if contador == 2:
		entra_menu()
	if contador == 3:
		sair_menu()
		contador = 1

# Essa funcao realiza a escolha dos menus
func escolha_menu():
	if Global.quantPlayers == 1 and Global.DefinirPlayer == 1:
		escolhaMenu = 1
		ui_dindi.show()
	if Global.quantPlayers == 1 and Global.DefinirPlayer == 2:
		escolhaMenu = 2
		ui_kiwi.show()
	if Global.quantPlayers == 2:
		escolhaMenu = 3
		ui_dindi.show()
		ui_kiwi.show()
		
# Essa funcao entra no menu, quando chamada
func entra_menu(): 
	if escolhaMenu == 1:
		menu1p_dindi.show()
	if escolhaMenu == 2:
		menu1p_kiwi.show()
	if escolhaMenu == 3:
		menu2p.show()

# Essa funcao sai do menu, quando chamada
func sair_menu():
	if escolhaMenu == 1:
		menu1p_dindi.hide()
	if escolhaMenu == 2:
		menu1p_kiwi.hide()
	if escolhaMenu == 3:
		menu2p.hide()
		
#func botoesApertados():
	
		
# Essa funcao coloca a informacao dentro da instancia "label", como "str" - string
func valoresMenu():
	## Dois Players
	# Dindi
	get_node("ui_dindi/dindiSementeAmarela").set_text(str(Global.dindiSementeAmarela))
	get_node("menuPausa_p2/Dindi/dindiSementeAmarela").set_text(str(Global.dindiSementeAmarela))
	get_node("menuPausa_p2/Dindi/dindiSementeRoxa").set_text(str(Global.dindiSementeRoxa))
	get_node("menuPausa_p2/Dindi/dindiSementeVerde").set_text(str(Global.dindiSementeVerde))
	get_node("menuPausa_p2/Dindi/dindiChaveAmarela").set_text(str(Global.dindiChaveAmarela))
	get_node("menuPausa_p2/Dindi/dindiChaveRoxa").set_text(str(Global.dindiChaveRoxa))
	
	# Kiwi
	get_node("ui_kiwi/kiwiSementeAmarela").set_text(str(Global.kiwiSementeAmarela))
	get_node("menuPausa_p2/Kiwi/kiwiSementeAmarela").set_text(str(Global.kiwiSementeAmarela))
	get_node("menuPausa_p2/Kiwi/kiwiSementeRoxa").set_text(str(Global.kiwiSementeRoxa))
	get_node("menuPausa_p2/Kiwi/kiwiSementeVerde").set_text(str(Global.kiwiSementeVerde))
	get_node("menuPausa_p2/Kiwi/kiwiChaveAmarela").set_text(str(Global.kiwiChaveAmarela))
	get_node("menuPausa_p2/Kiwi/kiwiChaveRoxa").set_text(str(Global.kiwiChaveRoxa))
	
	## Player 1 - Dindi
	get_node("menuPausa_p1_dindi/dindiSementeAmarela").set_text(str(Global.dindiSementeAmarela))
	get_node("menuPausa_p1_dindi/dindiSementeRoxa").set_text(str(Global.dindiSementeRoxa))
	get_node("menuPausa_p1_dindi/dindiSementeVerde").set_text(str(Global.dindiSementeVerde))
	get_node("menuPausa_p1_dindi/dindiChaveAmarela").set_text(str(Global.dindiChaveAmarela))
	get_node("menuPausa_p1_dindi/dindiChaveRoxa").set_text(str(Global.dindiChaveRoxa))
	
	## Player 2 - Kiwi
	get_node("menuPausa_p1_kiwi/kiwiSementeAmarela").set_text(str(Global.kiwiSementeAmarela))
	get_node("menuPausa_p1_kiwi/kiwiSementeRoxa").set_text(str(Global.kiwiSementeRoxa))
	get_node("menuPausa_p1_kiwi/kiwiSementeVerde").set_text(str(Global.kiwiSementeVerde))
	get_node("menuPausa_p1_kiwi/kiwiChaveAmarela").set_text(str(Global.kiwiChaveAmarela))
	get_node("menuPausa_p1_kiwi/kiwiChaveRoxa").set_text(str(Global.kiwiChaveRoxa))

func animacaoChaves():
# Chave desperta
	if Global.dindiChaveAmarela > 0:
		chaveAmarelaD1.play("AmarelaC")
		chaveAmarelaD2.play("AmarelaC")
	if Global.dindiChaveRoxa > 0:
		chaveRoxaD2.play("RoxaC")
		chaveRoxaD1.play("RoxaC")
	if Global.kiwiChaveAmarela > 0:
		chaveAmarelaK1.play("AmarelaC")
		chaveAmarelaK2.play("AmarelaC")
	if Global.kiwiChaveRoxa > 0:
		chaveRoxaK1.play("RoxaC")
		chaveRoxaK2.play("RoxaC")

# Chave dorme
	if Global.dindiChaveAmarela <= 0:
		chaveAmarelaD1.play("AmarelaNC")
		chaveAmarelaD2.play("AmarelaNC")
	if Global.dindiChaveRoxa <= 0:
		chaveRoxaD2.play("RoxaNC")
		chaveRoxaD1.play("RoxaNC")
	if Global.kiwiChaveAmarela <= 0:
		chaveAmarelaK1.play("AmarelaNC")
		chaveAmarelaK2.play("AmarelaNC")
	if Global.kiwiChaveRoxa <= 0:
		chaveRoxaK1.play("RoxaNC")
		chaveRoxaK2.play("RoxaNC")
	

