extends Node2D

# Botoes de linguagens
onready var botaoIngles = get_node("EntradaLinguagem/Botoes/Ingles")
onready var botaoPortugues = get_node("EntradaLinguagem/Botoes/Portugues")
onready var botaoEspanhol = get_node("EntradaLinguagem/Botoes/Espanhol")

# Cenas
onready var EntradaLinguagem = get_node("EntradaLinguagem")

# Historias
onready var historiaPortugues = get_node("historia_portugues")
onready var historiaEspanhol = get_node("historia_espanhol")
onready var historiaIngles = get_node("historia_ingles")

# Animacao
onready var animacaoHistoria = $EntradaTexto/AnimationHistoria

#var proximaCena = preload("res://UI/Entradas/Entradas.tscn")

func _ready():
	# Entradas
	EntradaLinguagem.show()
	
##	# Historias
	historiaEspanhol.hide()
	historiaIngles.hide()
	historiaPortugues.hide()

	# Linguagem
	TranslationServer.set_locale("en")
	
func _physics_process(delta):
	EscolhaLinguagem()# Escolhe a linguagem
	QuadroHistoria() # Quadro de historia
	
func EscolhaLinguagem():
	if botaoIngles.pressed == true: # Ingles
		Global.portugues = false
		Global.ingles = true
		Global.espanhol = false
		EntradaLinguagem.hide()
		TranslationServer.set_locale("en")
		
	if botaoPortugues.pressed == true: # Portugues
		Global.ingles = false
		Global.portugues = true
		Global.espanhol = false
		EntradaLinguagem.hide()
		TranslationServer.set_locale("pt_BR")
		
	if botaoEspanhol.pressed == true: # Espanhol
		Global.portugues = false
		Global.ingles = false
		Global.espanhol = true
		EntradaLinguagem.hide()
		TranslationServer.set_locale("es")
		
func QuadroHistoria():
	if Global.ingles == true:
		historiaIngles.show()
		if Input.is_action_pressed("iniciar"):
			get_tree().change_scene("res://UI/menu_principal/MenuPrincipal.tscn") # Isso leva para outra cena
#		animacaoHistoria.play("historia_portugues")
		
	if Global.portugues == true:
		historiaPortugues.show()
		if Input.is_action_pressed("iniciar"):
			get_tree().change_scene("res://UI/menu_principal/MenuPrincipal.tscn") # Isso leva para outra cena
		
	if Global.espanhol == true:
		historiaEspanhol.show()
		if Input.is_action_pressed("iniciar"):
			get_tree().change_scene("res://UI/menu_principal/MenuPrincipal.tscn") # Isso leva para outra cena



