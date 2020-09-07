extends KinematicBody

# ============================================================================== #
##################################################################################
##################################################################################
##################################################################################
# PARA USAR ESSE SCRIPT, SERA NECESSARIO O SEGUINTE:
# ESSE SCRIPT DEVE SER INJETADO EM UM NO "KinematicBody"
# 1 - DECLARAR UMA VARIAVEL NO OUTRO SCRIPT DA SEGUINTE FORMA:
# EX: var comportamentos = preload("res://pacoteNPC.tscn")
# 2 - INSTANCIAR
# EX: var listaDeComportamentos = comportamentos.instance()
# AGORA PODE USAR AS FUNCOES
##################################################################################
##################################################################################
##################################################################################
# ============================================================================== #
# PROPRIEDADES
# energiaAtual
# energiaMaxima
# energiaMinima
# posicAlvo

#---------------------------------------------------------------------------------
################################## DECISOES ######################################
#---------------------------------------------------------------------------------

# ---------------------------- DECISAO DE ROTACAO --------------------------------
# Se colidir com um objeto, define uma nova rotacao ##### FALTA AJUSTAR
# Para usar esse, paredes e objetos devem fazer parte do grupo objeto
func get_escolhaParaOndeIr(grupoDeColisao, energiaAtual, delta):
	set_forcaEmpuraX(forcaDeEmpurrao, delta) # Empurra o objeto no eixo X
	if grupoDeColisao == "Objeto":
		escolhaAleatoria(delta) # Escolha aleatoria para andar
	if energiaAtual < 19:
		get_decisaoAcoes(delta)

# ----------------------------- DECISAO DE ATAQUE -------------------------------
# Escolhe quem vai atacar
func get_escolhaInimigo(energiaMaxima, posicAlvo, delta):
	# Seleciona qual vai ser o personagem que sofrera dano
	if Global.estadoEnergiaDindi <= energiaMaxima and Global.estadoEnergiaKiwi <= energiaMaxima:
		match escolhar:
			DINDI: 
				return posicAlvo = Global.DindiPosic 
				
			KIWI:
				return posicAlvo = Global.KiwiPosic
				
	# Se a energia de dindi for menor que zero, ele vai persegui apenas kiwi
	if Global.estadoEnergiaDindi < energiaMaxima/4:
		return posicAlvo = Global.KiwiPosic
		
	# Se a energia de kiwi for menor que zero, ele vai perseguir apenas dindi
	if Global.estadoEnergiaKiwi < energiaMaxima/4:
		return posicAlvo = Global.DindiPosic

# ----------------------------- DECISAO DE ACAO -------------------------------
func get_decisaoAcoes(delta):
	if max_energia == 20:
		get_Rotacao(posicAlvo, delta)
		mover_perseguir(delta)
	
	if max_energia <= 19 and max_energia >= 11:
		get_Rotacao(posicAlvo, delta)
		atirarAlvo(delta)
	
	if max_energia <= 10:
		get_Rotacao(posicAlvo, delta)
		mover_perseguir(delta)
		
#---------------------------------------------------------------------------------
################################## CONTROLES ######################################
#---------------------------------------------------------------------------------		
		
# ----------------------------- CONTROLA O TIRO -------------------------------
# Funcao de atirar no alvo
func atirarAlvo(posicAlvo, delta):
#	if max_energia >= 10:
	contaTiro += 1
	get_Rotacao(posicAlvo, delta) # Pode ser que isso aqui cause erro nos outros - ALERTA!!!
	# Quanto maior os valores, menor a quantidade de tiros
	if contaTiro >= 16: 
		set_AtirarSemente(classeDeSemente, delta)
	if contaTiro >= 17:
		contaTiro = 0


#---------------------------------------------------------------------------------
################################ COMPORTAMENTOS ##################################
#---------------------------------------------------------------------------------

# ------------------------- COMPORTAMENTO DE SEGUIR ------------------------------
# SEGUIR
func get_Perseguir(posicAlvo, minhaPosicao, velocidade, delta): 
	var velocidade_desejada = posicAlvo - minhaPosicao
	velocidade_desejada = velocidade_desejada.normalized()
	#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	return move_and_slide(velocidade_desejada * velocidade)

# ---------------------- COMPORTAMENTO DE REPELIR ----------------------------
# REPELIR
func get_repelir(minhaPosicao, posicAlvo, velocidade, delta):
	var velocidade_desejada = minhaPosicao - posicAlvo
	velocidade_desejada = velocidade_desejada.normalized()
	#return move_and_collide(velocidade_desejada * VELOCIDADE * delta)
	return move_and_slide(velocidade_desejada * velocidade)

# ---------------------- COMPORTAMENTO DE ATIRAR ----------------------------
# ATIRAR
# Para usar essa funcao, seveser feito o segunte
# Declarar um variavel "preload" para classeDeSemente
# EX: var bola = preload("res://objeto/bola.tscn")
# Instanciar um classe "Position3D" no no raiz 
func set_AtirarSemente(classeDeSemente, delta):
	get_Rotacao(posicAlvo, delta)
	# Isso instancia o no da Bola, podendo pegar dados dele
	var bola = classeDeSemente.instance()
	# O objeto bola, usa a funcao start_inimigo, com os paramentros
	bola.start_inimigo($Position3D.global_transform, delta)
	# Isso adiciona um no filho da bola, com a malha  ao no do player, na posicao do Position3D
	get_parent().add_child(bola)

# ------------------- COMPORTAMENTO DE FICAR PARADO --------------------------
# Funcao parado
func set_parado(delta):
	get_Rotacao(posicAlvo, delta)
	move_and_collide(Vector3(0, 0, 0), delta)

# ------------------- COMPORTAMENTO DE FICAR PARADO --------------------------
func set_forcaEmpuraX(forcaDeEmpurrao, delta):
	forcaDeEmpurrao -= Vector3(0,0,1)
	forcaDeEmpurrao = forcaDeEmpurrao.normalized()
	return move_and_slide(forcaDeEmpurrao * delta))
	
# ----------------------- COMPORTAMENTO DE COLISAO --------------------------

func get_colisao(energiaMinima, energiaAtual,  minhaPosicao, energia):
	# Ataque de tiro
	if Global.colidioAlvo == minhaPosicao:
		energiaAtual -= 5
		Global.colidioAlvo = Vector3(0, 0, 0)
	
	# Ataque de tiro infinito
	if Global.colidioAlvoInfi == minhaPosicao:
		energiaAtual -= 1
		Global.colidioAlvoInfi = Vector3(0, 0, 0)
		
	# Impede que o valor mude mais que o limite
	if energiaAtual == energiaMinima:
		energiaAtual = energia

# ----------------------- COMPORTAMENTO DE ROTACAO --------------------------	
# Rotacao
# Olha para o alvo - Alvo e a posicao do player
func get_Rotacao(posicAlvo, delta):
	posicAlvo.normalized()
	return look_at(posicAlvo, Vector3(0, 1, 0) * delta)
	
# Rotacao de rotorno - Alvo e a posicao inicial
func get_Rotacao_retorno(posicInicial, delta):
	posicInicial.normalized()
	return look_at(posicAlvo, Vector3(0, 1, 0) * delta)


# ----------------------- COMPORTAMENTO DE ANDAR SOBRE PIVO --------------------------
# O comportamento sempre vai ser aleatorio, mas a forma como os pivos sao organizados
# e o que define o comportamento
# OBS: Mais de um inimigo no cenario, faz com que eles forme filas
# Quando mais pivores, mais voce deve adicionar a lista
# Existe 8 pivores, indo ate H

####### ESSA E A FUNCAO QUE DEVE SER UTILIZADA
func get_DecisaoDeCaminhada(delta):
	decisao(Global.A, 1, delta)
	decisao(Global.B, 2, delta)
	decisao(Global.C, 3, delta)

# --------------------------------------------------------------------------------
########### MOTOR DE MOVIMENTO UTILIZADO NA VERSAO "get_DecisaoDeCaminhada(delta)"
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
# --------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
######################################## GRAVIDADE ###############################
#---------------------------------------------------------------------------------
func set_Gravidade(velocidade_y, gravidade, delta):
	# Isso calcula a gravidade
	velocidade_y.y -= gravidade * delta
	# Funcao de movimento
	return move_and_slide(velocidade_y, Vector3.UP)
	
#---------------------------------------------------------------------------------
################################## ANIMACAO ####################################
#---------------------------------------------------------------------------------
# PARA USAR ESSAS FUNCOES, A ANIMACAO DEVE SER DECLARADA EM UMA VARIAVEL NO COMECO
# DEVE FAZER PARTE DA MESMA CLASSE
# EX: onready var animacao = $player/AnimationPlayer
# ------------------------------- INICIAR A ANIMACAO -----------------------------
func set_IniciarAnimacao(animacao, name):
	return animacao.play(name)
	
# -------------------------- RETORNA NOME DA ANIMACAO ----------------------------
func get_NomeDaAnimacao(animacao):
	return animacao.current_animation
	
# ----------------------- RETORNA POSICAO DA ANIMACAO ----------------------------
func get_PosicaoDaAnimacao(animacao):
	return animacao.current_animation_position	
	
# --------------------- DEFINE VELOCIDADE DE ANIMACAO ----------------------------
func get_VelocidadeDeAnimacao(animacao, valor):
	return animacao.playback_speed = valor
	
# -------------------------- PARA ANIMACAO E RESETA ------------------------------
func get_ParaAnimacaoEReseta(animacao):
	return animacao.stop(true)
	
# ------------------------- PARA ANIMACAO SEM RESETAR ----------------------------
func get_ParaAnimacao(animacao):
	return animacao.stop(true)

#---------------------------------------------------------------------------------
###################################### AUDIO #####################################
#---------------------------------------------------------------------------------
# ----------------------------- AUDIO - INICIA ------------------------------------
# efeitoDeSomGlobal e uma forma de pausar o som para nao permanecer depois de executado
# UM SINGLETON - AUTOLOAD
# efeitoDeSom e o efeito sonoro ja declarado preveamente
# EX: onready var somDeBatida = $EfeitosSonoros/somDeBatida
func setIniciaAudio(efeitoDeSom, efeitoDeSomGlobal):
	if efeitoDeSomGlobal == true:
		efeitoDeSom.play()
		efeitoDeSomGlobal = false
		
# ------------------------------ AUDIO - PARAR -----------------------------------		
func setParaAudio(efeitoDeSom, efeitoDeSomGlobal):
	if efeitoDeSomGlobal == true:
		efeitoDeSom.stop()
		efeitoDeSomGlobal = false

#---------------------------------------------------------------------------------
############################## RANDOMIZADOR ######################################
#---------------------------------------------------------------------------------
# Essa funcao realiza a escolha de forma randomica
# Os metodos dentro da funcao trabalha com matriz(array)
# Metodo shuffle - Embaralha a matriz de maneira que o itens tenha uma ordem aleatoria
# Metodo front - Retorna o primeiro elemento da matriz, ou null se estiver vazia
# EX: get_EscolhaRandomica([TESTE1, TESTE2])
func get_EscolhaRandomica(matriz):
	matriz.shuffle()
	return matriz.front()
	
	
	
