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

## SOM - EFEITOS (ALTERAR APENAS AQUI)
onready var puloDindi = $EfeitosSonoros/PuloDindi
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



onready var coletaSementeVerde = $EfeitosSonoros/coletaSementeVerde
onready var coletaSementeAmarela = $EfeitosSonoros/coletaSementeAmarela
onready var coletaSementeRoxa = $EfeitosSonoros/coletaSementeRoxa

onready var coletaChaveAmarela = $EfeitosSonoros/coletaChaveAmarela
onready var coletaChaveRoxa = $EfeitosSonoros/coletaChaveRoxa


# Inimigos
onready var alvo = get_tree().get_nodes_in_group("inimigo")

# INVENTARIO - Definem o inventario do personagem
var max_energia = 20
var min_energia = 0
var energia = 0

var energia4 = 20
var energia3 = 15
var energia2 = 10
var energia1 = 5
var energia0 = 0

var velocidade_y = 0
var aterrar = false
#var posicaoDindi

var podeAtirar = false

# Posicao
var minhaPosicao

# Animacao
onready var animacaoDindi = $Dindi/AnimationPlayer

# Barra de saude
onready var saude = $BarraSaudeAnim

# Variaveis de movimento
var direcao_movimento = 0
var direcao_rotacao = 0

var ataque = false

#var teste = 0

# Posicao Inicial - Personagem
var posicInicial

#var atirando = false # Usar para controlar animacao de tiro e impedir outra animacao

# Personagem fica parado
var parado = 0

############################## INICIAL ########################################
func _ready():
#	Global.dindiSementeAmarela = 50
	Global.posicaoDindi = transform.origin
	Global.DindiPosic = transform.origin
	Global.DindiRot = rotation_degrees.y
	posicInicial = global_transform.origin
	
	# Declara energia em variavel global
	Global.estadoEnergiaDindi = max_energia
	ataque = false
	parado = 0
	animacao("parado") # Quando parado
	

############################## MAIN LOOP ########################################
func _physics_process(delta):
	#posicaoDindi = transform.origin
	# Coleta a posicao do personagem e coloca na variavel global
	
	buracoMorte() # Buraco da morte
	
	#pararAnimacaoNaPorta() # para animacao quando chega na porta
	
	teleport() # Teleport
	
#	fimTempo() # Quando o tempo acabar, o personagem morre

	morte() # Quando a morte encostar
	
	continueSementeRoxa() # Isso garante o continue, equanto existir sementes roxa
	
	sincAudioAnima() # Sincroniza audio com as animacoes

	colisao() # Reduz a energia do player
	
	saude_contador() # Realiza a contagem da saude do player
	
	efeitosSonorosLista() # EFEITOS SONOROS
	
	# Quando ficar parada, executa essa animacao
	animacao("parado") # Quando parado
	parado = 0
	
	Global.posicaoDindi = transform.origin
	Global.DindiPosic = transform.origin
	Global.DindiRot = rotation_degrees.y
	
	# Declara energia em variavel global
	Global.estadoEnergiaDindi = max_energia
		
	# Minha posicao
	minhaPosicao = transform.origin
		
	# Isso zera direcao_movimento e direcao_rotacao em cada quadro
	direcao_movimento = 0
	direcao_rotacao = 0
	
	
	# Entradas do teclado - MOVIMENTACAO
	if Input.is_action_pressed("cima_dindi"):
		direcao_movimento += 1
		animacao("pular")
		parado = 1
		
	if Input.is_action_pressed("baixo_dindi"):
		direcao_movimento -= 1
		animacao("pular")
		parado = 1
		
	if Input.is_action_pressed("direita_dindi"):
		direcao_rotacao -= 1
		parado = 1
		
	if Input.is_action_pressed("esquerda_dindi"):
		direcao_rotacao += 1
		parado = 1
	
	# Isso faz girar
	rotation_degrees.y += direcao_rotacao * ROTACAO * delta
	var velocidade_movimento = global_transform.basis.z * VELOCIDADE * direcao_movimento
	velocidade_movimento.y = velocidade_y
	move_and_slide(velocidade_movimento, Vector3(0, 1, 0))
	
	# Gravidade
	var aterrada = aterrar
	aterrar = is_on_floor()
	velocidade_y -= GRAVIDADE * delta
	# Se estiver no chao, reduz esse valor
	if aterrar:
		velocidade_y = -0.1
	# Se a velocidade de y for menor que a velocidade_queda, ele se torna o valor
	if velocidade_y < -VELOCIDADE_QUEDA:
		velocidade_y = -VELOCIDADE_QUEDA
		
# Atirar
func _unhandled_input(event):
	# Semente Amarela - limitada
	if event.is_action_pressed("atirar_dindi"):
		if Global.dindiSementeAmarela > 0:
			var bola = bolaJogar.instance()
			bola.start($Position3D.global_transform)
			get_parent().add_child(bola)
			Global.dindiSementeAmarela -= 1
			Global.somJogarSementeAmarela = true
			somEfeitosSonoros(jogarSementeAmarela, Global.somJogarSementeAmarela)
			animacao("atirar")
			parado = 1
			

	# semente infinita - fraca
	if Global.dindiSementeAmarela == 0:
		if event.is_action_pressed("atirar_dindi"):
			var bola = bolaJogarInfi.instance()
			bola.start($Position3D.global_transform)
			get_parent().add_child(bola)
			Global.somJogarSementeAzul = true
			somEfeitosSonoros(jogarSementeAzul, Global.somJogarSementeAzul)
			animacao("atirar")
			parado = 1

# Essa funcao e responsavel por empurar o player, quando enconstar no inimigo
func retornoColisaoInimigo(valorNedativoRet):
	var velocidade_movimento = global_transform.basis.z * VELOCIDADE * valorNedativoRet
	move_and_slide(velocidade_movimento, Vector3(0, 1, 0))
	
func ataqueCC():
	if Input.is_action_pressed("selecionar_dindi"):
		Iniciar_animacao("Reset")
		Iniciar_animacao("Ataque")
		ataque = true
		
func audioPulo(): # Nao sendo utilizada
#	if animacaoDindi.has_animation("Jump"):
	if animacaoDindi.current_animation_position >= 0.01:
		Global.somPuloDindi = true
		somEfeitosSonoros(puloDindi, Global.somPuloDindi)
		
func sincAudioAnima(): # Usando esse aqui
	# Isso resolve o problema do som no pulo
	if animacaoDindi.current_animation == "JumpFlatten":
		if animacaoDindi.current_animation_position >= 0.1 and animacaoDindi.current_animation_position <= 0.12:
			Global.somPuloDindi = true
			somEfeitosSonoros(puloDindi, Global.somPuloDindi)

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
############################### MECANICAS ##########################################
#---------------------------------------------------------------------------------
# Teletransporte
func teleport(): 
	if Global.teleportArea1 == true and Global.teleportNome1 == "Dindi":
		# translation coloc na posicao exata, definida 
		self.translation = Global.teleportDestino1
		
	if Global.teleportArea2 == true and Global.teleportNome2 == "Dindi":
		self.translation = Global.teleportDestino2
		
	if Global.teleportArea3 == true and Global.teleportNome3 == "Dindi":
		self.translation = Global.teleportDestino3
		
	if Global.teleportArea4 == true and Global.teleportNome4 == "Dindi":
		self.translation = Global.teleportDestino4
		
	if Global.teleportArea5 == true and Global.teleportNome5 == "Dindi":
		self.translation = Global.teleportDestino5
		
# Essa parte cria o continue da semente roxa - COLOCAR UMA ANIMACAO, QUANDO RETORNAR
func continueSementeRoxa():
	if Global.dindiSementeRoxa > 0 and max_energia <= 0:
		# translation coloc na posicao exata, definida 
		self.translation = posicInicial
		Global.dindiSementeRoxa -= 1
		max_energia = 20
		
		
# Buraco da morte
func buracoMorte():
	if Global.buracoMorte == true and Global.buracoMorteNome == "Dindi":
		max_energia = 0
		
	if Global.dindiSementeRoxa == 0 and max_energia <= 0:
		queue_free()
		
func morte():
	if Global.buracoMorte == true:
		max_energia = 0
		Global.buracoMorte = false
		animacao("morrer")
		
	if Global.morteEncostaDindi == true and Global.morteNomeDindi == "Dindi":
		max_energia = 0
		animacao("morrer")
		if animacaoDindi.current_animation == "Morte":
			if animacaoDindi.current_animation_position >= 2.4:
				queue_free()
		
	if Global.dindiSementeRoxa == 0 and max_energia <= 0:
		animacao("morrer")
		if animacaoDindi.current_animation == "Morte":
			if animacaoDindi.current_animation_position >= 2.4:
				queue_free()
		
func fimTempo():
	if Global.fimTempo == true:
		max_energia = 0
		queue_free()
	
#---------------------------------------------------------------------------------
############################### ENERGIA ##########################################
#---------------------------------------------------------------------------------
# Reduz enerdia do player
func colisao():
	# Se a bola enconstar no player
	if Global.colidioAlvo == minhaPosicao:
		max_energia -= 1
		Global.colidioAlvo = Vector3(0, 0, 0)
		animacaoDindi.play("Pancada")
	if max_energia == min_energia:
		max_energia = energia
		animacaoDindi.play("Pancada")
		
	# Se o inimigo enconstar no player
	if Global.inimigoEncosta == "PlayerDindi":
		max_energia -= 1
		retornoColisaoInimigo(-30) # Quando o inimigo enconsta, o player e jogado
		animacaoDindi.play("Pancada")
		Global.dindiEncostaInimigo = true
		
############################## ANIMACAO #######################################
func Iniciar_animacao(name):
	if animacaoDindi.current_animation == name:
		return
	animacaoDindi.play(name)

func animacao(nome):
	if nome == "atirar":
		animacaoDindi.play("Atirar")
		animacaoDindi.playback_speed = 3
		
	if nome == "pular":
		animacaoDindi.play("JumpFlatten")
		animacaoDindi.playback_speed = 1.5
		
	if nome == "parado":
		if parado == 0:
			if animacaoDindi.current_animation_position >= 2.4 or animacaoDindi.current_animation_position == 0:
				animacaoDindi.play("Idle2")
				animacaoDindi.playback_speed = 1
				
	if nome == "morrer":
		animacaoDindi.play("Morte")
		animacaoDindi.playback_speed = 1.5
		
	if nome == "dano":
		animacaoDindi.play("Pancada")
		animacaoDindi.playback_speed = 1.5

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

func pararAnimacaoNaPorta():
	if Global.areaPorta == true:
		animacaoDindi.stop(true)
	
# Nao sei se esta sendo utilizado
func _on_CollisionShape_tree_entered():
	pass


