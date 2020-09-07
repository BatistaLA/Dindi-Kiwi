extends KinematicBody
# FINALIZADO
#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

# Constantes de metricas
const VELOCIDADE = 6
const RETORNO_VELOCIDADE = 1
const VELOCIDADE_MAX = 8
const ROTACAO = 180
var velocidade_y = Vector3()
var gravidade : float = 15.0

# Velocidade
var velocidadeDeEmpurrao = 4
var forcaDeEmpurrao = Vector3(0,0,0)

######################## COISAS PARA MODIFICAR #############################
onready var animacaoTicongo = $Ticongo/AnimationPlayer # Animacao
onready var saude = $BarraSaudeAnim # Barra de saude
onready var colisaoPlay = $ColisaoPersonagem # Colisao do player com o inimigo
var bolaJogar = preload("res://Cenarios/Kit/Objetos/Bola_Tiro.tscn") # Semente
#############################################################################

# Constantes de enumeracao de escolhas
enum {
	DINDI,
	KIWI
}
var escolhar = DINDI  # Variaveis de escolha
#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

# # verificacao de estados - IA
var minhaPosicao
var posicAlvo = Vector3(0, 0 , 0)
var posicao_inicial

# Usaod para reduzir a quantidade de tiros
var contaTiro = 0
var velocidade_desejada

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

# Pivos de locomocao, quando colidir com StaticBody
enum {
	DIREITA,
	ESQUERDA
}
var escolhaPivoLocomocao = DIREITA

var posicFrente
var grupoColisao = null

var tempoDeTroca = 2 # Esse e o tempo de troca entre as rotacoes
var contadorObjetoColisao = 0

var escolha = false # Escolha
var escolhaContada = 0

#---------------------------------------------------------------------------------
############################## ANTES DE TUDO ###################################
#---------------------------------------------------------------------------------
func _ready():
	posicao_inicial = transform.origin
	Global.zonaMorte = false
	Global.inimigoEncosta = null
	posicAlvo = Vector3(1, 1 , 1)
	randomize() 
	
#---------------------------------------------------------------------------------
############################# PROCESSO FISICO - MAIN LOOP ########################
#---------------------------------------------------------------------------------
func _physics_process(delta): 
	minhaPosicao = transform.origin # Coleta a posicao inicial
	colisao() # Isso reduz a energia
	saude_contador() # Barra de saude
	escolhaInimigo(delta) # Essa funcao escolhe que vai atacar
	decisaoAcoes(delta) # Decide o que deve ser feito
	escolhaAleatoria(delta) # Escolha para onde ir
	gravidade(delta) # Grvidade

#---------------------------------------------------------------------------------
##################### COMPORTAMENTO DE DECISAO DE ACOES ##########################
#---------------------------------------------------------------------------------

# Essa funcao escolhe que vai atacar
func escolhaInimigo(delta):
	# Seleciona qual vai ser o personagem que sofrera dano
	if Global.estadoEnergiaDindi <= 20 and Global.estadoEnergiaKiwi <= 20:
		match escolhar:
			DINDI: 
				posicAlvo = Global.DindiPosic 
				
			KIWI:
				posicAlvo = Global.KiwiPosic
				
	# Se a energia de dindi for menor que zero, ele vai persegui apenas kiwi
	if Global.estadoEnergiaDindi < 5:
		posicAlvo = Global.KiwiPosic
		
	# Se a energia de kiwi for menor que zero, ele vai perseguir apenas dindi
	if Global.estadoEnergiaKiwi < 5:
		posicAlvo = Global.DindiPosic

# Essa funcao realiza escolhas aleatorias da posicao do inimigo
func escolhaAleatoria(delta):
	print(escolhaContada)
	if escolha == false:
		match escolhaPivoLocomocao:
			ESQUERDA:
				rotation_degrees.y += 30 * delta
				Iniciar_animacao("Jump")
				
			DIREITA:
				rotation_degrees.y -= 30 * delta
				Iniciar_animacao("Jump")
				
	if escolhaContada < 1: # Isso faz rotacionar
		escolha = false
	if escolhaContada >= 1: # Isso faz andar
		escolha = true
		forcaEmpuraX(delta)
	if escolhaContada >= 3: # Isso reseta
		escolhaContada = 0
		

func decisaoAcoes(delta):
	if max_energia == 20:
		escolhaAleatoria(delta)
	
	if max_energia <= 19 and max_energia >= 11:
		Rotacao(posicAlvo, delta)
		atirarAlvo(delta)
	
	if max_energia <= 10:
		Rotacao(posicAlvo, delta)
		mover_perseguir(delta)

# Funcao de atirar no alvo
func atirarAlvo(delta):
#	if max_energia >= 10:
	contaTiro += 1
	Rotacao(posicAlvo, delta) # Pode ser que isso aqui cause erro nos outros - ALERTA!!!
	# Quanto maior os valores, menor a quantidade de tiros
	if contaTiro >= 16: 
		bola_atirar(delta)
	if contaTiro >= 17:
		contaTiro = 0
		
#---------------------------------------------------------------------------------
######################################## GRAVIDADE ###############################
#---------------------------------------------------------------------------------
func gravidade(delta):
	# Isso calcula a gravidade
	velocidade_y.y -= gravidade * delta
	# Funcao de movimento
	return move_and_slide(velocidade_y, Vector3.UP)
	
#---------------------------------------------------------------------------------
############################## PACOTE DE COMPORTAMENTOS ##########################
#---------------------------------------------------------------------------------
# Essa função vai fazer o NPC se mover
# Funcao de perseguir
func mover_perseguir(delta):
	#Rotacao(posicAlvo, delta) 
	perseguir(delta)
	Iniciar_animacao("Jump")
	
		
# Funcao parado
func parado(delta):
#	Rotacao(posicAlvo, delta)
	#RotacaoSemNormalizar(posicAlvo, delta)
	move_and_collide(Vector3(0, 0, 0), delta)
	Iniciar_animacao("Jump")

func forcaEmpuraX(delta):
	Iniciar_animacao("Jump")
	forcaDeEmpurrao -= Vector3(0,0,1)
	forcaDeEmpurrao = forcaDeEmpurrao.normalized()
	return translate(move_and_slide(forcaDeEmpurrao * delta))

	
#---------------------------------------------------------------------------------
################################## ANIMACAO ####################################
#---------------------------------------------------------------------------------
# Funcao de animacao
func Iniciar_animacao(name):
	if animacaoTicongo.current_animation == name:
		return
	animacaoTicongo.play(name)
	
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
		queue_free()
		
#---------------------------------------------------------------------------------
############################### POSICOES #######################################
#---------------------------------------------------------------------------------
# Funcao de olhar para o alvo
func Rotacao(Alvo, delta):
	Alvo.normalized()
	return look_at(Alvo, Vector3(0, 1, 0) * delta)
	
func RotacaoSemNormalizar(Alvo, delta):
	look_at(Alvo, Vector3(0, 1, 0) * delta)

# Funcao de retorno
func Rotacao_retorno(delta):
	var olhar_aqui = fugir(delta)
	return look_at(olhar_aqui, Vector3(0, 2, 0))
	
#---------------------------------------------------------------------------------
########################### COMPORTAMENTOS ATIVOS ################################
#---------------------------------------------------------------------------------
# Comportamentos
# Funcao de perseguir
func perseguir(delta): 
	var velocidade_desejada = posicAlvo - minhaPosicao
	velocidade_desejada = velocidade_desejada.normalized()
	#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	return move_and_slide(velocidade_desejada * VELOCIDADE)
	

	
# Funcao de fulga
func fugir(delta):
	var velocidade_desejada = minhaPosicao - posicAlvo
	velocidade_desejada = velocidade_desejada.normalized()
	#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	return move_and_slide(velocidade_desejada * VELOCIDADE)
	
# Funcao de atirar bola
func bola_atirar(delta):
	Rotacao(posicAlvo, delta)
	# Isso instancia o no da Bola, podendo pegar dados dele
	var bola = bolaJogar.instance()
	# O objeto bola, usa a funcao start_inimigo, com os paramentros
	bola.start_inimigo($Position3D.global_transform, delta)
	# Isso adiciona um no filho da bola, com a malha  ao no do player, na posicao do Position3D
	get_parent().add_child(bola)
	Iniciar_animacao("throw")
	
#---------------------------------------------------------------------------------
############################### ENERGIA ##########################################
#---------------------------------------------------------------------------------

func colisao():
	# Ataque de tiro
	if Global.colidioAlvo == minhaPosicao:
		max_energia -= 5
		Global.colidioAlvo = Vector3(0, 0, 0)
	
	# Ataque de tiro infinito
	if Global.colidioAlvoInfi == minhaPosicao:
		max_energia -= 1
		Global.colidioAlvoInfi = Vector3(0, 0, 0)
		
	# Impede que o valor mude mais que o limite
	if max_energia == min_energia:
		max_energia = energia

#---------------------------------------------------------------------------------
############################### SENSORES #########################################
#---------------------------------------------------------------------------------

# Isso recebe a colisao entre os corpos 
func _on_colisaoCorpo_body_entered(body):
	Global.inimigoEncosta = body.name
	Global.posicInimigoEncosta = transform.origin
	if get_tree().get_nodes_in_group("Objeto"):
		grupoColisao = "Objeto"

func _on_colisaoCorpo_body_exited(body):
	Global.inimigoEncosta = null
	grupoColisao = null
	
#---------------------------------------------------------------------------------
############################## TEMPORIZADOR ######################################
#---------------------------------------------------------------------------------

# Sera escolhida de forma randomica
func _on_Timer_timeout():
	escolhaContada += 1
	# Tempo de escolha personagem
	$Timer.wait_time = tempoDeTroca
	escolhar = escolha([DINDI, KIWI])
	escolhaPivoLocomocao = escolha([ESQUERDA, DIREITA])
	
#---------------------------------------------------------------------------------
############################## RANDOMIZADOR ######################################
#---------------------------------------------------------------------------------
# Essa funcao realiza a escolha de forma randomica
# Os metodos dentro da funcao trabalha com matriz(array)
# Metodo shuffle - Embaralha a matriz de maneira que o itens tenha uma ordem aleatoria
# Metodo front - Retorna o primeiro elemento da matriz, ou null se estiver vazia
func escolha(matriz):
	matriz.shuffle()
	return matriz.front()
	


