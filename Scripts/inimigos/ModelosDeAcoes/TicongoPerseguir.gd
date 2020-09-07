extends KinematicBody

# FINALIZADO

#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

# Constantes de metricas
const VELOCIDADE = 2#4
const RETORNO_VELOCIDADE = 1
const VELOCIDADE_MAX = 8
const ROTACAO = 180
var velocidade_y = Vector3()
var gravidade : float = 15.0


######################## COISAS PARA MODIFICAR #############################
onready var animacaoTicongo = $Ticongo/AnimationPlayer # Animacao
onready var saude = $BarraSaudeAnim # Barra de saude
onready var colisaoPlay = $ColisaoPersonagem # Colisao do player com o inimigo
#############################################################################

# Constantes de enumeracao de escolhas
enum {
	DINDI,
	KIWI
}

# Variaveis de escolha
var escolhar = DINDI

#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

# # verificacao de estados - IA
var minhaPosicao
var posicAlvo = Vector3(0, 0 , 0)
var posicao_inicial

# INVENTARIO - Definem o inventario do personagem
var max_energia = 20
var min_energia = 0
var energia = 0

var energia4 = 20
var energia3 = 15
var energia2 = 10
var energia1 = 5
var energia0 = 0

enum {
	PARADO,
	ANDANDO
}

var escolhaMovimento = PARADO

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
	minhaPosicao = transform.origin
	colisao() # Qaundo o personagem colide, sofre danos
	escolhaInimigo(delta) # Realiza a escolha do personagem
	saude_contador() # Barra de saude
	gravidade(delta)
	
	match escolhaMovimento:
		PARADO:
			parado(delta) # Parado
		ANDANDO:
			mover_perseguir(delta) # Ele so vai perseguir o player

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

#---------------------------------------------------------------------------------
############################## PACOTE DE COMPORTAMENTOS ##########################
#---------------------------------------------------------------------------------
# Essa função vai fazer o NPC se mover
# Funcao de perseguir
func mover_perseguir(delta):
	Rotacao(posicAlvo, delta) 
	perseguir(delta)
	Iniciar_animacao("Jump")
	
# Funcao parado
# USADA APENAS PARA TRAVAR A ACELERACAO DAS BOLAS
func parado(delta):
	Rotacao(posicAlvo, delta)
	move_and_collide(Vector3(0, 0, 0), delta)
	Iniciar_animacao("Jump")
	
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
######################################## GRAVIDADE ###############################
#---------------------------------------------------------------------------------
func gravidade(delta):
	# Isso calcula a gravidade
	velocidade_y.y -= gravidade * delta
	# Funcao de movimento
	return move_and_slide(velocidade_y, Vector3.UP)
		
#---------------------------------------------------------------------------------
############################### POSICOES #######################################
#---------------------------------------------------------------------------------
# Funcao de olhar para o alvo
func Rotacao(Alvo, delta):
	Alvo.normalized()
	return look_at(Alvo, Vector3(0, 1, 0) * delta)
	
#---------------------------------------------------------------------------------
##################### COMPORTAMENTOS ATIVOS #############################
#---------------------------------------------------------------------------------
# Comportamentos
# Funcao de perseguir
func perseguir(delta): 
	var velocidade_desejada = posicAlvo - minhaPosicao
	velocidade_desejada = velocidade_desejada.normalized()
	#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	return move_and_slide(velocidade_desejada * VELOCIDADE)
	
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


func _on_colisaoCorpo_body_exited(body):
	Global.inimigoEncosta = null
	
#---------------------------------------------------------------------------------
############################## TEMPORIZADOR ######################################
#---------------------------------------------------------------------------------

# Sera escolhida de forma randomica
func _on_Timer_timeout():
	
	# Tempo de escolha personagem
	$Timer.wait_time = escolha([3, 5])
	escolhar = escolha([DINDI, KIWI])
	escolhaMovimento = escolha([PARADO, ANDANDO])
	
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
	
