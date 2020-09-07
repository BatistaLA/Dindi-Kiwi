extends KinematicBody

############################## VARIAVEIS ######################################

# Constantes de metricas
const VELOCIDADE = 5
const ROTACAO = 180
const GRAVIDADE = 100
const VELOCIDADE_QUEDA = 30

# Bola 
var bolaJogar = preload("res://Cenarios/Kit/Objetos/Bola_Tiro.tscn")
var bolaJogarInfi = preload("res://Cenarios/Kit/Objetos/Bola_TiroInfinita.tscn")

# INVENTARIO - Definem o inventario do personagem
var max_energia = 20
var min_energia = 0
var energia = 0
var quantidadeBolas = 5

var energia4 = 20
var energia3 = 15
var energia2 = 10
var energia1 = 5
var energia0 = 0

# Define volocidade da rotacao
var velocidade_y = 0
var aterrar = false
var posicaoDindi 

## SOM - EFEITOS (ALTERAR APENAS AQUI)
onready var puloDindi = $EfeitosSonoros/PuloKiwi
onready var jogarSementeAmarela = $EfeitosSonoros/jogarSementeAmarela
onready var jogarSementeAzul = $EfeitosSonoros/jogarSementeAzul

#--------------------#
onready var batidaSementeAmarelaRocha = $EfeitosSonoros/batidaSementeAmarelaRocha
onready var batidaSementeAmarelaMadeira = $EfeitosSonoros/batidaSementeAmarelaMadeira
onready var batidaSementeAmarelaVidro = $EfeitosSonoros/batidaSementeAmarelaVidro
onready var batidaSementeAmarelaMetal = $EfeitosSonoros/batidaSementeAmarelaMetal
onready var batidaSementeAmarelaCorpo = $EfeitosSonoros/batidaSementeAmarelaCorpo

onready var batidaSementeAzulRocha = $EfeitosSonoros/batidaSementeAzulRocha
onready var batidaSementeAzulMadeira = $EfeitosSonoros/batidaSementeAzulMadeira
onready var batidaSementeAzulVidro = $EfeitosSonoros/batidaSementeAzulVidro
onready var batidaSementeAzulMetal = $EfeitosSonoros/batidaSementeAzulMetal
onready var batidaSementeAzulCorpo = $EfeitosSonoros/batidaSementeAzulCorpo

#onready var morte = $EfeitosSonoros/Morte

onready var coletaSementeVerde = $EfeitosSonoros/coletaSementeVerde
onready var coletaSementeAmarela = $EfeitosSonoros/coletaSementeAmarela
onready var coletaSementeRoxa = $EfeitosSonoros/coletaSementeRoxa

onready var coletaChaveAmarela = $EfeitosSonoros/coletaChaveAmarela
onready var coletaChaveRoxa = $EfeitosSonoros/coletaChaveRoxa

# Posicao
var minhaPosicao

# Animacao
onready var animacaoKiwi = $Kiwi/AnimationPlayer

# Barra de saude
onready var saude = $BarraSaudeAnim

# Posicao inicial - Personagem
var posicInicial

# Personagem fica parado
var parado = true

############################## INICIO ###################################
func _ready():
	Global.KiwiPosic = transform.origin
	Global.KiwiRot = rotation_degrees.y
	posicInicial = global_transform.origin
	
	
	# Minha posicao
	minhaPosicao = transform.origin
	
	# Declara energia em variavel global
	Global.estadoEnergiaKiwi = max_energia
	
############################## MAIN LOOP ########################################
func _physics_process(delta):
	Global.KiwiPosic = transform.origin
	Global.KiwiRot = rotation_degrees.y
	
	teleport() # Teleport 
	
	buracoMorte() # Burado da morte
	
	continueSementeRoxa() # Isso garante o continue, equanto existir sementes roxa
	
	#pararAnimacaoNaPorta() # Parar animacao, quando na porta
	
#	fimTempo() # Quando o tempo acabar, o personagem morre

	morte() # Quando a morte encostar
	
	efeitosSonorosLista() # EFEITOS SONOROS
	
	sincAudioAnima() # Sincroniza som do pulo
	
	# Minha posicao
	minhaPosicao = transform.origin
	
	# Declara energia em variavel global
	Global.estadoEnergiaKiwi = max_energia
	
	# Quando ficar parada, executa essa animacao
	parado = true
	animacao("parado") # Quando parado
	
	var direcao_movimento = 0
	var direcao_rotacao = 0
	# Entradas do teclado
	if Input.is_action_pressed("cima_kiwi"):
		direcao_movimento += 1
		animacao("pular")
		parado = false
	if Input.is_action_pressed("baixo_kiwi"):
		direcao_movimento -= 1
		animacao("pular")
		parado = false
	if Input.is_action_pressed("direita_kiwi"):
		direcao_rotacao -= 1
		parado = false
	if Input.is_action_pressed("esquerda_kiwi"):
		direcao_rotacao += 1
		parado = false

	# Isso faz girar
	rotation_degrees.y += direcao_rotacao * ROTACAO * delta
	var velocidade_movimento = global_transform.basis.x * VELOCIDADE * direcao_movimento
	velocidade_movimento.y = velocidade_y
	move_and_slide(velocidade_movimento, Vector3(0, 1, 0))
	
	# Gravidade
	var aterrada = aterrar
	aterrar = is_on_floor()
	velocidade_y -= GRAVIDADE * delta
	if aterrar:
		velocidade_y = -0.1
	if velocidade_y < -VELOCIDADE_QUEDA:
		velocidade_y = -VELOCIDADE_QUEDA
			
	colisao()
	saude_contador()
	
# Atirar
func _unhandled_input(event):
	# Semente amarela - limitada
	if event.is_action_pressed("atirar_kiwi"):
		if Global.kiwiSementeAmarela > 0:
			animacao("atirar")
			parado = false
#			if animacaoKiwi.current_animation_position >= 1:
			var bola = bolaJogar.instance()
			bola.start($Position3D.global_transform)
			get_parent().add_child(bola)
			Global.somJogarSementeAmarela = true
			Global.kiwiSementeAmarela -= 1
			somEfeitosSonoros(jogarSementeAmarela, Global.somJogarSementeAmarela)
			
	# semente infinita - fraca
	if Global.kiwiSementeAmarela == 0:
		if event.is_action_pressed("atirar_kiwi"):
			animacao("atirar")
			parado = false
#			if animacaoKiwi.current_animation_position >= 1:
			var bola = bolaJogarInfi.instance()
			bola.start($Position3D.global_transform)
			Global.somJogarSementeAzul = true
			get_parent().add_child(bola)
			somEfeitosSonoros(jogarSementeAzul, Global.somJogarSementeAzul)
			
		
# Essa funcao e responsavel por empurar o player, quando enconstar no inimigo
func retornoColisaoInimigo(valorNedativoRet):
	var velocidade_movimento = global_transform.basis.z * VELOCIDADE * valorNedativoRet
	move_and_slide(velocidade_movimento, Vector3(0, 1, 0))
	
func sincAudioAnima():
	# Isso resolve o problema do som no pulo
	if animacaoKiwi.current_animation == "Jump":
		if animacaoKiwi.current_animation_position >= 0.1 and animacaoKiwi.current_animation_position <= 0.12:
			Global.somPuloKiwi = true
			somEfeitosSonoros(puloDindi, Global.somPuloKiwi)
			

	
#---------------------------------------------------------------------------------
################################## SAUDE ####################################
#---------------------------------------------------------------------------------
# Funcao de animacao
func barra_saude(frame):
	return saude.play(frame)
	
func saude_contador():
	if max_energia == energia4:
		barra_saude("Completo")
	if max_energia == energia3:
		barra_saude("tres")
	if max_energia == energia2:
		barra_saude("dois")
	if max_energia == energia1:
		barra_saude("um")
	if max_energia == energia0:
		barra_saude("zero")

#---------------------------------------------------------------------------------
############################### MECANICA ##########################################
#---------------------------------------------------------------------------------
# Teletransporte
func teleport(): 
	if Global.teleportArea1 == true and Global.teleportNome1 == "Kiwi":
		# translation coloc na posicao exata, definida 
		self.translation = Global.teleportDestino1
		
	if Global.teleportArea2 == true and Global.teleportNome2 == "Kiwi":
		self.translation = Global.teleportDestino2
		
	if Global.teleportArea3 == true and Global.teleportNome3 == "Kiwi":
		self.translation = Global.teleportDestino3
		
	if Global.teleportArea4 == true and Global.teleportNome4 == "Kiwi":
		self.translation = Global.teleportDestino4
		
	if Global.teleportArea5 == true and Global.teleportNome5 == "Kiwi":
		self.translation = Global.teleportDestino5
		
# Essa parte cria o continue da semente roxa - COLOCAR UMA ANIMACAO, QUANDO RETORNAR
func continueSementeRoxa():
	if Global.kiwiSementeRoxa > 0 and max_energia <= 0:
		# translation coloc na posicao exata, definida 
		self.translation = posicInicial
		Global.kiwiSementeRoxa -= 1
		max_energia = 20
		
# Buraco da morte
func buracoMorte():
	if Global.buracoMorte == true and Global.buracoMorteNome == "Kiwi":
		max_energia = 0
		
	if Global.kiwiSementeRoxa == 0 and max_energia <= 0:
		queue_free()
		
# MORTE
func morte():
	if Global.buracoMorte == true:
		max_energia = 0
		Global.buracoMorte = false
		
	if Global.morteEncostaKiwi == true and Global.morteNomeKiwi == "Kiwi":
		max_energia = 0
		queue_free()
		
	if Global.kiwiSementeRoxa == 0 and max_energia <= 0:
		queue_free()
		
# Fim do tempo
func fimTempo():
	if Global.fimTempo == true:
		max_energia = 0
		queue_free()
#---------------------------------------------------------------------------------
############################### ENERGIA ##########################################
#---------------------------------------------------------------------------------
# Colisao de semente e inimigo
func colisao():
	# Se a semente enconstar no inimigo
	if Global.colidioAlvo == minhaPosicao:
		max_energia -= 1
		Global.colidioAlvo = Vector3(0, 0, 0)
#		print(max_energia)
	if max_energia == min_energia:
		max_energia = energia
		
	# Se enconstar no inimigo
	if Global.inimigoEncosta == "PlayerKiwi":
		max_energia -= 1
		retornoColisaoInimigo(-30)
		Global.kiwiEncostaInimigo = true

############################## ANIMACAO #######################################
func Iniciar_animacao(name):
	if animacaoKiwi.current_animation == name:
		return
	animacaoKiwi.play(name)
	
func animacao(nome):
	if nome == "atirar":
		animacaoKiwi.play("shoot")
		animacaoKiwi.playback_speed = 3
		
	if nome == "pular":
		animacaoKiwi.play("Jump")
		animacaoKiwi.playback_speed = 1.5
		
	if nome == "parado":
		if parado == true:
			if animacaoKiwi.current_animation_position >= 2 or animacaoKiwi.current_animation_position == 0:
				animacaoKiwi.play("Idle")
				animacaoKiwi.playback_speed = 1

func pararAnimacaoNaPorta():
	if Global.areaPorta == true:
		animacaoKiwi.stop(true)

############################## EFEITOS SONOROS ##################################
func somEfeitosSonoros(efeitoDeSom, efeitoDeSomGlobal):
	if efeitoDeSomGlobal == true:
		efeitoDeSom.play()
		efeitoDeSomGlobal = false
		
func efeitosSonorosLista():
	# SEMENTE AMARELA COLIDINDO COM OBJETOS
	if Global.somColisaoAmarelaCorpo == true:
		batidaSementeAmarelaCorpo.play()
		Global.somColisaoAmarelaCorpo = false
	if Global.somColisaoAmarelaMadeira == true:
		batidaSementeAmarelaMadeira.play()
		Global.somColisaoAmarelaMadeira = false
	if Global.somColisaoAmarelaMetal == true:
		batidaSementeAmarelaMetal.play()
		Global.somColisaoAmarelaMetal = false
	if Global.somColisaoAmarelaRocha == true:
		batidaSementeAmarelaRocha.play()
		Global.somColisaoAmarelaRocha = false
	if Global.somColisaoAmarelaVidro == true:
		batidaSementeAmarelaVidro.play()
		Global.somColisaoAmarelaVidro = false

	# SEMENTE AZUL COLIDINDO COM OBJETOS
	if Global.somColisaoAzulCorpo == true:
	 	batidaSementeAzulCorpo.play()
	 	Global.somColisaoAzulCorpo = false
	if Global.somColisaoAzulMadeira == true:
		batidaSementeAzulMadeira.play()
		Global.somColisaoAzulMadeira = false
	if Global.somColisaoAzulMetal == true:
		batidaSementeAzulMetal.play()
		Global.somColisaoAzulMetal = false
	if Global.somColisaoAzulRocha == true:
		batidaSementeAzulRocha.play()
		Global.somColisaoAzulRocha = false
	if Global.somColisaoAzulVidro == true:
		batidaSementeAzulVidro.play()
		Global.somColisaoAzulVidro = false

	# EFEITOS DE COLETA DE SEMENTES
	if Global.somColetaSementeVerde == true:
		coletaSementeVerde.play()
		Global.somColetaSementeVerde = false
	if Global.somColetaSementeAmarela == true:
		coletaSementeAmarela.play()
		Global.somColetaSementeAmarela = false
	if Global.somColetaSementeRoxa == true:
		coletaSementeRoxa.play()
		Global.somColetaSementeRoxa = false
		
	# EFEITOS DE COLETA DE CHAVES
	if Global.somColetaChaveAmarela == true:
		coletaChaveAmarela.play()
		Global.somColetaChaveAmarela = false
	if Global.somColetaChaveRoxa == true:
		coletaChaveRoxa.play()
		Global.somColetaChaveRoxa = false

# Marcador de tiros
func _on_CollisionShape_tree_entered():
	pass # Replace with function body.
