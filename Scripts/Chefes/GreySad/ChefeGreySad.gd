extends KinematicBody

var gravidade : float = 15.0
var velocidade = 2
var velocidade_y = Vector3()
var rotacao = 180

######################## COISAS PARA MODIFICAR #############################
onready var animacao = $GreySad/AnimationPlayer
onready var saude = $BarraSaudeAnim # Barra de saude
onready var colisaoPlay = $ColisaoPersonagem # Colisao do player com o inimigo
var bolaJogar = preload("res://Cenarios/Kit/Objetos/Bola_Tiro.tscn") # Semente
#############################################################################

enum {
	DINDI,
	KIWI
}

var escolharPlayer = DINDI # Variaveis de escolha


# # verificacao de estados - IA
var minhaPosicao
var posicAlvo = Vector3(0, 0 , 0)
var posicao_inicial

# Usaod para reduzir a quantidade de tiros
var contaTiro = 0
var velocidade_desejada

# INVENTARIO - Definem o inventario do personagem
var max_energia = 50
var min_energia = 0
var energia = 0
var quantidadeBolas = 5

var energia4 = 50
var energia3 = 35
var energia2 = 25
var energia1 = 5
var energia0 = 0

# Escolha do que fazer
enum{
	BATENDO,
	SEGUIR, 
	ATIRAR
	
}

var escolhaDeDecisao = PARADO


# Escolha entre parar e atirar
enum{
	PARADO,
	ATIRANDO
}

var escolhaDeAtirar = PARADO

# controla animacao
var animacaoEscolhida = 1
# animacaoEscolhida = 1 - Pulo
# animacaoEscolhida = 2 - Bater
# animacaoEscolhida = 3 - Atirar
# animacaoEscolhida = 4 - Morrer

#---------------------------------------------------------------------------------
####################################### CHEFE - GREY SAD #########################
#---------------------------------------------------------------------------------

func _ready():
	pass
	
func _physics_process(delta):
	minhaPosicao = transform.origin
	Gravidade(delta) # Controla a gravidade do chefe
	Comportamentos(delta) # Define o comportamento do chefe
	colisao() # Quando o player colide com o inimigo, ou a semente
	escolhaInimigo(delta) # Faz a escolha do player
	saude_contador() # Contador de saude
	baterNoInimigo() # Quando enconstar, inicia animacao
	ControleDeAnimacoes()
	
	
func Gravidade(delta):
	# Isso calcula a gravidade
	velocidade_y.y -= gravidade * delta
	# Funcao de movimento
	return move_and_slide(velocidade_y, Vector3.UP)
	
func ControleDeAnimacoes():
	if animacaoEscolhida == 1:
		Iniciar_animacao("Jump")
	if animacaoEscolhida == 2:
		Iniciar_animacao("Bater")
	if animacaoEscolhida == 3:
		Iniciar_animacao("throw")
	if animacaoEscolhida == 4:
		pass
	
func baterNoInimigo():
	if Global.dindiEncostaInimigo == true:
		animacaoEscolhida = 2
		Global.dindiEncostaInimigo = false
	if Global.kiwiEncostaInimigo == true:
		animacaoEscolhida = 2
		Global.kiwiEncostaInimigo = false
	
func Comportamentos(delta):
	match escolhaDeDecisao:
		SEGUIR:
			var velocidade_desejada = posicAlvo - minhaPosicao
			velocidade_desejada = velocidade_desejada.normalized()
			#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
			return move_and_slide(velocidade_desejada * velocidade)
			animacaoEscolhida = 1
		ATIRAR:
			Atirar(delta)
			
			
func Atirar(delta):
	match escolhaDeAtirar:
		ATIRANDO:
			#if max_energia >= 10:
			contaTiro += 1
			Rotacao(posicAlvo, delta) # Pode ser que isso aqui cause erro nos outros - ALERTA!!!
			# Quanto maior os valores, menor a quantidade de tiros
			if contaTiro >= 16: 
				bola_atirar(delta)
			if contaTiro >= 17:
				contaTiro = 0
		PARADO:
			Rotacao(posicAlvo, delta)
			#RotacaoSemNormalizar(posicAlvo, delta)
			move_and_collide(Vector3(0, 0, 0), delta)
			animacaoEscolhida = 1
	
# Funcao de animacao
func Iniciar_animacao(name):
	if animacao.current_animation == name:
		return
	animacao.play(name)

# Essa funcao escolhe que vai atacar
func escolhaInimigo(delta):
	# Seleciona qual vai ser o personagem que sofrera dano
	if Global.estadoEnergiaDindi <= 20 and Global.estadoEnergiaKiwi <= 20:
		match escolharPlayer:
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

# Funcao de olhar para o alvo
func Rotacao(Alvo, delta):
	Alvo.normalized()
	return look_at(Alvo, Vector3(0, 1, 0) * delta)
	

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
################################## TEMPO ####################################
#---------------------------------------------------------------------------------
# Contador de tempo
func _on_Timer_timeout():
	$Timer.wait_time = 3
	escolharPlayer = escolha([DINDI, KIWI])
	escolhaDeDecisao = escolha([SEGUIR, ATIRAR])
	escolhaDeAtirar = escolha([PARADO, ATIRANDO])
	
	
# SEMENTE
func bola_atirar(delta):
	Rotacao(posicAlvo, delta)
	# Isso instancia o no da Bola, podendo pegar dados dele
	var bola = bolaJogar.instance()
	# O objeto bola, usa a funcao start_inimigo, com os paramentros
	bola.start_inimigo($Position3D.global_transform, delta)
	# Isso adiciona um no filho da bola, com a malha  ao no do player, na posicao do Position3D
	get_parent().add_child(bola)
	animacaoEscolhida = 3
	
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
############################## RANDOMIZADOR ######################################
#---------------------------------------------------------------------------------
# Essa funcao realiza a escolha de forma randomica
# Os metodos dentro da funcao trabalha com matriz(array)
# Metodo shuffle - Embaralha a matriz de maneira que o itens tenha uma ordem aleatoria
# Metodo front - Retorna o primeiro elemento da matriz, ou null se estiver vazia
func escolha(matriz):
	matriz.shuffle()
	return matriz.front()
