extends KinematicBody
# FINALIZADO

### OBS: ****
# ESSE SCRIPT DECESSITA QUE A ZONA DA MORTE SEJA INSTANCIADOS NA CENA
# Diretoriao dos Pivores: res://Cenarios/objetos_de_acao/
# ****

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
var bolaJogar = preload("res://Cenarios/Kit/Objetos/Bola_Tiro.tscn") # Semente
#############################################################################

# Constantes de enumeracao de escolhas
enum {
	DINDI,
	KIWI
}

var escolhar = DINDI # Variaveis de escolha
#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

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
	colisao() # Reducao de life com colisao
	saude_contador() # Barra de saude
	zonadaMorte(delta) # Zona da morte
	gravidade(delta)
	
#---------------------------------------------------------------------------------
################################ ZONA DA MORTE ###################################
#---------------------------------------------------------------------------------

func zonadaMorte(delta):
	if Global.zonaMorte == false:
		# Isso escolhe os inimigos de forma randomica
		escolhaInimigo(delta)
		Rotacao(posicAlvo, delta) 
		parado(delta)

	if Global.zonaMorte == true:
		# Decide acoes a serem realizadas
		decisaoAcoes(delta)
		# Isso escolhe os inimigos de forma randomica
		escolhaInimigoZonaMorte(delta)
		

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

# Escolhe o inimigo dentro da zona da morte
func escolhaInimigoZonaMorte(delta):
	# Seleciona qual vai ser o personagem que sofrera dano
	if Global.zonaMorteDindi == "PlayerDindi" and Global.zonaMorteKiwi == "PlayerKiwi":
		match escolhar:
			DINDI: 
				posicAlvo = Global.DindiPosic
			KIWI:
				posicAlvo = Global.KiwiPosic
					
	# Se a energia de dindi for menor que zero, ele vai persegui apenas kiwi
	if Global.zonaMorteDindi == null and Global.zonaMorteKiwi == "PlayerKiwi":
		posicAlvo = Global.KiwiPosic
			
	# Se a energia de kiwi for menor que zero, ele vai perseguir apenas dindi
	if Global.zonaMorteDindi == "PlayerDindi" and Global.zonaMorteKiwi == null:
		posicAlvo = Global.DindiPosic

# Essa funcao decide o que sera feito, de acordo com a energia do inimigo
func decisaoAcoes(delta):	
	if max_energia >= 16:
		Rotacao(posicAlvo, delta)
		mover_perseguir(delta)
	
	if max_energia <= 15 and max_energia >= 11:
		Rotacao(posicAlvo, delta)
		atirarAlvo(delta)
	
	if max_energia <= 10 and max_energia > 5:
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
############################### POSICOES #######################################
#---------------------------------------------------------------------------------
# Funcao de olhar para o alvo
func Rotacao(Alvo, delta):
	Alvo.normalized()
	return look_at(Alvo, Vector3(0, 1, 0) * delta)
	
func RotacaoSemNormalizar(Alvo, delta):
	look_at(Alvo, Vector3(0, 1, 0) * delta)
	
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
	
