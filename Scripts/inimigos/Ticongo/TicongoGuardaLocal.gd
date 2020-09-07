extends KinematicBody
# FINALIZADO

### OBS: ****
# ESSE SCRIPT DECESSITA QUE OS PIVORES SEJAM INSTANCIADOS NA CENA
# TAMBEM NECESSITA QUE SEJAM ORGANIZADOS DA FORMA CORRETA NO SCRIPT
# NA FUNCAO CAMINHADA
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
# Variaveis de escolha
var escolhar = DINDI
#---------------------------------------------------------------------------------
############################## VARIAVEIS #########################################
#---------------------------------------------------------------------------------

# # verificacao de estados - IA
var estado = 2
#onready var alvo = get_tree().get_nodes_in_group("players")
var colisao = 0
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
	Global.inimigoEncosta = null
	posicAlvo = Vector3(1, 1 , 1)
	randomize() 
	
#---------------------------------------------------------------------------------
############################# PROCESSO FISICO - MAIN LOOP ########################
#---------------------------------------------------------------------------------
func _physics_process(delta): 
	minhaPosicao = transform.origin # Coleta minha posicao em tempo real
	colisao() # Isso reduz a energia, ao colidir com o player
	escolhaInimigo(delta) # Realiza a escolha do personagem na cena
	saude_contador() # Barra de saude
	decisaoAcoes(delta) # Dentro da decisao de acao, esta a decisao dos pivores
	gravidade(delta)
	
#---------------------------------------------------------------------------------
##################### COMPORTAMENTO DE DECISAO DE ACOES ##########################
#---------------------------------------------------------------------------------

func escolhaInimigo(delta): # Essa funcao escolhe aleatoriamente quem vai atacar
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

func decisaoAcoes(delta): # Realiza decisoes do qu fazer, de acordo com a sua energia

	if max_energia >= 11:
		mover_caminhar(delta) # DEVE TER O PIVO - Ele vai mover sobre os pivores
	
	if max_energia <= 10 and max_energia > 5:
		Rotacao(posicAlvo, delta)
		atirarAlvo(delta)
	
	if max_energia <= 5:
		Rotacao(posicAlvo, delta)
		mover_perseguir(delta)

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

func mover_perseguir(delta): # Funcao de perseguir o player
	#Rotacao(posicAlvo, delta) 
	perseguir(delta)
	Iniciar_animacao("Jump")
	
func mover_caminhar(delta): # Funcao de caminhar nos locais indicados pelos pivores
	caminhada(delta)
	Iniciar_animacao("Jump")
	
func atirarAlvo(delta): # Funcao de atirar no alvo - Reduz a velocidade dos tiros
	contaTiro += 1
	Rotacao(posicAlvo, delta)
	if contaTiro >= 16: 
		bola_atirar(delta)
	if contaTiro >= 17:
		contaTiro = 0
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
############################### ROTACAO #######################################
#---------------------------------------------------------------------------------
# Funcao de olhar para o alvo
func Rotacao(Alvo, delta):
	Alvo.normalized()
	return look_at(Alvo, Vector3(0, 1, 0) * delta)

#---------------------------------------------------------------------------------
##################### COMPORTAMENTOS PRIMITIVOS #############################
#---------------------------------------------------------------------------------

func perseguir(delta):  # Funcao de perseguir
	var velocidade_desejada = posicAlvo - minhaPosicao
	velocidade_desejada = velocidade_desejada.normalized()
	return move_and_slide(velocidade_desejada * VELOCIDADE)
	
func bola_atirar(delta): # Funcao de atirar bola
	Rotacao(posicAlvo, delta)
	# Isso instancia o no da Bola, podendo pegar dados dele
	var bola = bolaJogar.instance()
	# O objeto bola, usa a funcao start_inimigo, com os paramentros
	bola.start_inimigo($Position3D.global_transform, delta)
	# Isso adiciona um no filho da bola, com a malha  ao no do player, na posicao do Position3D
	get_parent().add_child(bola)
	Iniciar_animacao("throw")
	
#---------------------------------------------------------------------------------
##################### COMPORTAMENTOS PASSIVOS ####################################
#---------------------------------------------------------------------------------

# O comportamento sempre vai ser aleatorio, mas a forma como os pivos sao organizados
# e o que define o comportamento
# OBS: Mais de um inimigo no cenario, faz com que eles forme filas
# Quando mais pivores, mais voce deve adicionar a lista
func caminhada(delta):
	decisao(Global.A, 1, delta)
	decisao(Global.B, 2, delta)
	decisao(Global.C, 3, delta)

func pivoAndar(alvo, delta): # Responsavel pela movimentacao entre os pivores
	Rotacao(alvo, delta)
	var velocidade_desejada = alvo - global_transform.origin
	velocidade_desejada = velocidade_desejada.normalized()
	move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	#move_and_slide(velocidade_desejada * VELOCIDADE)
	
	# NOTA: move_and_colide causa tremedeira quando chega no destino
	# nesse caso e melhor utilizar move_and_slide
	
func decisao(alvo, numero, delta): # Responsavel pela decisao de movimentacao
	if Global.contadorPivo == numero:
		pivoAndar(alvo, delta)
	# Isso vai zerar o contador - pode ser usado para criar o loop de voltas
	# Parar no ultimo local - Valor: 0
	# Repetira a mesma acao - Valor: 1
	if Global.contadorPivo == 4:
		Global.contadorPivo = 1

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
	