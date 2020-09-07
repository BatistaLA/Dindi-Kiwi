extends Spatial

# Comandos
var direcao = 0
var enter = false
var sair = true
var dentroDasOpcoesDeEscolha = false

# Luzes
onready var dindi = get_node("Luzes/spotDindi")
onready var kiwi = get_node("Luzes/spotKiwi")
onready var dindiKiwi = get_node("Luzes/spotDindiKiwi")
onready var saida = get_node("Luzes/spotSaida")

# Animacoes
onready var dindiAnim = $Players/umJogaro/Dindi/AnimationPlayer
onready var kiwiAnim = $Players/umJogaro/Kiwi/AnimationPlayer
onready var dindiAnim2 = $Players/doisJogadores/Dindi2/AnimationPlayer
onready var kiwiAnim2 = $Players/doisJogadores/Kiwi2/AnimationPlayer
onready var saidaAnim = $Porta/PortaGaleriaMadeira/PortaMadeira/AnimationPlayer

# Animacao da camera
onready var animacaoCamera = $AnimationCamera

# Players
onready var dindiPlayer1 = get_node("Players/umJogaro/Dindi")
onready var dindiPlayer2 = get_node("Players/doisJogadores/Dindi2")
onready var kiwiPlayer1 = get_node("Players/umJogaro/Kiwi")
onready var kiwiPlayer2 = get_node("Players/doisJogadores/Kiwi2")

onready var doisPlayersPrincipal = get_node("Players/doisJogadores")

# Titulo
onready var titulo = get_node("Titulo")

func _ready():
	dindi.hide()
	kiwi.hide()
	dindiKiwi.hide()
	saida.hide()
	sair = true
	
func _physics_process(delta):
	decisaoJogadorEntrada() # Isso toma a decisao de escolha
	desisaoJogadorSaida()
	resetValorDirecao() # Isso reseta os valores
	
func _unhandled_input(event):
	if event.is_action_pressed("direita_dindi"):
		direcao += 1
	if event.is_action_pressed("direita_kiwi"):
		direcao += 1
	if event.is_action_pressed("esquerda_dindi"):
		direcao -= 1
	if event.is_action_pressed("esquerda_kiwi"):
		direcao -= 1
	if event.is_action_pressed("iniciar"):
		enter = true
	
func decisaoJogadorEntrada():
	################## DOIS PLAYERS #################
	if direcao == 0: # Dois Jogadores
		if enter == false and sair == true:
			dindi.hide() # Isso e a luz em cima
			kiwi.hide() # Isso e a luz em cima - Desligada
			dindiKiwi.show() # Isso e a luz em cima - Ligada
			saida.hide() # Isso e a luz em cima
			dindiAnim2.play("Idle") # Animacao
			kiwiAnim2.play("Idle")
		
		if enter == true and dentroDasOpcoesDeEscolha == false:
			animacaoCamera.play("dindiKiwi")
			enter = false # Quando entra, coloca me falso para ficar preso la
			sair = false # Se ele sair, vai retornar para opcao de escolha
			titulo.hide() # Isso faz o titulo desaparecer
			dentroDasOpcoesDeEscolha = true # Isso trava a camera na escolha
			
			# Isso faz com que os outros players desapareca
			# Nesse, fica dois players
			dindiPlayer1.hide()
			kiwiPlayer1.hide()
			doisPlayersPrincipal.show()
			
		if Global.saidaMenuDoisJogadores == false:
			if animacaoCamera.current_animation_position >= 1.9:
				animacaoCamera.stop(false)
				Global.entradaMenuDoisJogadores = true # menu de opcoes
				
	################ SAIDA ###############
	if direcao == 1: # Saida
		if enter == false and sair == true:
			dindi.hide()
			kiwi.hide()
			dindiKiwi.hide()
			saida.show()
			
		if enter == true and dentroDasOpcoesDeEscolha == false:
			titulo.hide() # Isso faz o titulo desaparecer
			saidaAnim.play("Abrir")
			if saidaAnim.current_animation_position >= 0.8:
				get_tree().quit()
		
	################# KIWI #######################
	if direcao >= 2: # Um jogador - Kiwi
		if enter == false and sair == true:
			dindi.hide()
			kiwi.show()
			dindiKiwi.hide()
			saida.hide()
			kiwiAnim.play("Jump")
			kiwiAnim.playback_speed = 2
			
		if enter == true and dentroDasOpcoesDeEscolha == false:
			animacaoCamera.play("kiwi")
			enter = false
			sair = false
			titulo.hide() # Isso faz o titulo desaparecer
			dentroDasOpcoesDeEscolha = true # Isso trava a camera na escolha
			
			
			# Isso faz com que os outros players desapareca
			# Nesse, fica dois players
			dindiPlayer1.hide()
			kiwiPlayer1.show()
			doisPlayersPrincipal.hide()
			
		if Global.saidaMenuUmJogadorKiwi == false:
			if animacaoCamera.current_animation_position == 2:
				animacaoCamera.stop(false)
				Global.entradaMenuUmJogadorKiwi = true
		
	##################### DINDI ###################
	if direcao <= -1: # Um jogador - Dindi
		if enter == false and sair == true:
			dindi.show()
			kiwi.hide()
			dindiKiwi.hide()
			saida.hide()
			dindiAnim.play("Jump")
			dindiAnim.playback_speed = 2
			
		if enter == true and dentroDasOpcoesDeEscolha == false:
			animacaoCamera.play("dindi")
			enter = false
			sair = false
			titulo.hide() # Isso faz o titulo desaparecer
			dentroDasOpcoesDeEscolha = true # Isso trava a camera na escolha
			
			# Isso faz com que os outros players desapareca
			# Nesse, fica dois players
			dindiPlayer1.show()
			kiwiPlayer1.hide()
			doisPlayersPrincipal.hide()
			
		if Global.saidaMenuUmJogadorDindi == false:
			if animacaoCamera.current_animation_position == 2:
				animacaoCamera.stop(false)
				Global.entradaMenuUmJogadorDindi = true
		
func desisaoJogadorSaida():
	################ DINDI E KIWI ############
	if Global.saidaMenuDoisJogadores == true: # ISSO REVERTE, QUANDO APERTADO EM SAIR
		animacaoCamera.play_backwards("dindiKiwi") # Reverte a animacao
		enter = false
		sair = true
		dentroDasOpcoesDeEscolha = false
		
		Global.entradaMenuDoisJogadores = false # Isso faz com que o menu desapareca

		# Isso faz a luz aparecer
		dindi.hide()
		kiwi.hide()
		dindiKiwi.show()
		saida.hide()

		# Isso faz os personagens aparecer
		# ESSE DEVE SER COLOCADO NOS OUTROS, COMO ELE ESTA
		dindiPlayer1.show()
		kiwiPlayer1.show()
		doisPlayersPrincipal.show()
			
		if animacaoCamera.current_animation_position <= 0.1:
			animacaoCamera.stop(false)
		decisaoJogadorEntrada()
		Global.saidaMenuDoisJogadores = false # Isso faze ele sair do if e retornar a funcao de decisao inicial
		
	################ KIWI ############
	if Global.saidaMenuUmJogadorKiwi == true: # ISSO REVERTE, QUANDO APERTADO EM SAIR
		animacaoCamera.play_backwards("kiwi") # Reverte a animacao
		enter = false
		sair = true
		dentroDasOpcoesDeEscolha = false
		
		Global.entradaMenuUmJogadorKiwi = false # Isso faz com que o menu desapareca

		# Isso faz a luz aparecer
		dindi.hide()
		kiwi.show()
		dindiKiwi.hide()
		saida.hide()

		# Isso faz os personagens aparecer
		# ESSE DEVE SER COLOCADO NOS OUTROS, COMO ELE ESTA
		dindiPlayer1.show()
		kiwiPlayer1.show()
		doisPlayersPrincipal.show()
			
		if animacaoCamera.current_animation_position <= 0.1:
			animacaoCamera.stop(false)
		decisaoJogadorEntrada()
		Global.saidaMenuUmJogadorKiwi = false # Isso faze ele sair do if e retornar a funcao de decisao inicial
		
	
	################ DINDI ############
	if Global.saidaMenuUmJogadorDindi == true: # ISSO REVERTE, QUANDO APERTADO EM SAIR
		animacaoCamera.play_backwards("dindiKiwi") # Reverte a animacao
		enter = false
		sair = true
		dentroDasOpcoesDeEscolha = false
		
		Global.entradaMenuUmJogadorDindi = false # Isso faz com que o menu desapareca

		# Isso faz a luz aparecer
		dindi.show()
		kiwi.hide()
		dindiKiwi.hide()
		saida.hide()

		# Isso faz os personagens aparecer
		# ESSE DEVE SER COLOCADO NOS OUTROS, COMO ELE ESTA
		dindiPlayer1.show()
		kiwiPlayer1.show()
		doisPlayersPrincipal.show()
			
		if animacaoCamera.current_animation_position <= 0.1:
			animacaoCamera.stop(false)
		decisaoJogadorEntrada()
		Global.saidaMenuUmJogadorDindi = false # Isso faze ele sair do if e retornar a funcao de decisao inicial
		
	
	
func resetValorDirecao(): # Isso reseta os valores quando eles passam do limite
	if direcao < -1:
		direcao = -1
	
	if direcao > 2:
		direcao = 2
		
