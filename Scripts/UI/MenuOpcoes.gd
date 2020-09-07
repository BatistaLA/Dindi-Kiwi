extends Node2D


# =================================================================================
############################### Menu principal ####################################
# =================================================================================
############################### NOS NOS NOS #######################################
# --------------------------- NOs PRINCIPAIS ---------------------------------
onready var umJogadorPrincipalKiwi = get_node("UmJogadorKiwi")
onready var umJogadorPrincipalDindi = get_node("UmJogadorDindi")
onready var doisJogadoresPrincipal = get_node("DoisJogadores")
onready var remotoPrincipal = get_node("RemotoPrincipal") 
onready var remotoModos = get_node("RemotoModos")

# NO PRINCIPAL DE OPCAO - DINDI
onready var opcaoDindiPrincipal = get_node("OpcoesDindiPrincipal") # MOSTRA TODAS OPCOES

onready var opcaoDindiVideo = get_node("OpcoesDindiVideo")
onready var opcaoDindiControle = get_node("OpcoesDindiControle")
onready var opcaoDindiLinguagem = get_node("OpcoesDindiLinguagem")

# NO PRINCIPAL DE OPCAO - KIWI
onready var opcaoKiwiPrincipal = get_node("OpcoesKiwiPrincipal")# MOSTRA TODAS OPCOES

onready var opcaoKiwiVideo = get_node("OpcoesKiwiVideo")
onready var opcaoKiwiControle = get_node("OpcoesKiwiControle")
onready var opcaoKiwiLinguagem = get_node("OpcoesKiwiLinguagem")

# NO PRINCIPAL DE OPCAO - DOIS JOGADORES
onready var opcaoDoisJogadoresPrincipal = get_node("OpcoesDoisPrincipal")# MOSTRA TODAS OPCOES

onready var opcaoDoisJogadoresVideo = get_node("OpcoesDoisVideo")
onready var opcaoDoisJogadoresControle = get_node("OpcoesDoisControle")
onready var opcaoDoisJogadoresLinguagem = get_node("OpcoesDoisLinguagem")

onready var iniciarPrincipal = get_node("Iniciar") # Geral iniciar
onready var carregarJogoPrincipal = get_node("CarregarJogo") # Geral carregar jogo
onready var salasOnlinePrincipal = get_node("Salas") # Geral salas 
#onready var salvarJogoPrincipal = get_node("SalvarJogo") # geral salvar jogo

# =================================================================================
######################### Botoes de um jogador - Kiwi #############################
# =================================================================================
onready var botaoInicioUmJogadorKiwi = get_node("UmJogadorKiwi/Botoes/Inicio")
onready var botaoOpcaoUmJogadorKiwi = get_node("UmJogadorKiwi/Botoes/Opcoes")
onready var botaoSairUmJogadorKiwi = get_node("UmJogadorKiwi/Botoes/Sair")

# =================================================================================
######################### Botoes de um jogador - Dindi #############################
# =================================================================================
onready var botaoInicioUmJogadorDindi = get_node("UmJogadorDindi/Botoes/Inicio")
onready var botaoOpcaoUmJogadorDindi = get_node("UmJogadorDindi/Botoes/Opcoes")
onready var botaoSairUmJogadorDindi = get_node("UmJogadorDindi/Botoes/Sair")

# =================================================================================
############################## Botoes de dois jogadores ###########################
# =================================================================================
onready var botaoLocalDoisJogadores = get_node("DoisJogadores/Botoes/Local")
onready var botaoRemotoDoisJogadores = get_node("DoisJogadores/Botoes/Remoto")
onready var botaoOpcoesDoisJogadores = get_node("DoisJogadores/Botoes/Opcoes")
onready var botaoSairDoisJogadores = get_node("DoisJogadores/Botoes/Sair")

# =================================================================================
################################## Remoto #########################################
# =================================================================================
# ------------------------------- PRINCIPAL ---------------------------------------
# ------------------------------------------------------------------------------
onready var remotoBotaoSalas = get_node("RemotoPrincipal/BotoesPrincipal/Salas") # Salas - Tela principal
onready var remotoBotaoModos = get_node("RemotoPrincipal/BotoesPrincipal/Modos") # Modos - Tela principal
onready var remotoBotaoSair = get_node("RemotoPrincipal/BotoesPrincipal/Sair") # Sair - Tela principal
# -----------------------------------------------------------------------------
# ------------------------------- MODOS ---------------------------------------
onready var remotoBotaoModosHistoria = get_node("RemotoModos/BotoesDeModos/Historia") # Historia - Menu de modo
onready var remotoBotaoModosBatalha = get_node("RemotoModos/BotoesDeModos/Batalha") # Batalha - Menu de modo
onready var remotoBotaoModosSair = get_node("RemotoModos/BotoesDeModos/Sair") # Sair  - Menu de modo

# =================================================================================
################################## Opcoes #########################################
# =================================================================================


# ------------------------------ BOTOES - DINDI ----------------------------------
# --------------------------------- Principal ------------------------------------
onready var opcaoDindiBotaoPrincipalVideo = get_node("OpcoesDindiPrincipal/BotoesPrincipais/Video")
onready var opcaoDindiBotaoPrincipalControle = get_node("OpcoesDindiPrincipal/BotoesPrincipais/Controle")
onready var opcaoDindiBotaoPrincipalLinguagem = get_node("OpcoesDindiPrincipal/BotoesPrincipais/Linguagem")
onready var opcaoDindiBotaoPrincipalSair = get_node("OpcoesDindiPrincipal/BotoesPrincipais/Sair")

# SUBMENU
# --------------------------------- Video ------------------------------------
onready var opcaoDindiBotaoVideoSuavisa = get_node("OpcoesDindiVideo/BotoesDeVideo/Suavisar")
onready var opcaoDindiBotaoVideoResolucao = get_node("OpcoesDindiVideo/BotoesDeVideo/Resolucao")
onready var opcaoDindiBotaoVideoSair = get_node("OpcoesDindiVideo/BotoesDeVideo/Sair")

# --------------------------------- Controle ------------------------------------
onready var opcaoDindiBotaoControleTeclado = get_node("OpcoesDindiControle/BotoesDeControle/Teclado")
onready var opcaoDindiBotaoControleControle = get_node("OpcoesDindiControle/BotoesDeControle/Controle")
onready var opcaoDindiBotaoControleSair = get_node("OpcoesDindiControle/BotoesDeControle/Sair")

# --------------------------------- Linguagem ------------------------------------
onready var opcaoDindiBotaoLinguagemPortugues = get_node("OpcoesDindiLinguagem/BotoesDeLinguagem/Portugues")
onready var opcaoDindiBotaoLinguagemIngles = get_node("OpcoesDindiLinguagem/BotoesDeLinguagem/Ingles")
onready var opcaoDindiBotaoLinguagemEspanhol = get_node("OpcoesDindiLinguagem/BotoesDeLinguagem/Espanhol")
onready var opcaoDindiBotaoLinguagemSair = get_node("OpcoesDindiLinguagem/BotoesDeLinguagem/Sair")

# ------------------------------ BOTOES - KIWI ----------------------------------
# --------------------------------- Principal ------------------------------------
onready var opcaoKiwiBotaoPrincipalVideo = get_node("OpcoesKiwiPrincipal/BotoesPrincipais/Video")
onready var opcaoKiwiBotaoPrincipalControle = get_node("OpcoesKiwiPrincipal/BotoesPrincipais/Controle")
onready var opcaoKiwiBotaoPrincipalLinguagem = get_node("OpcoesKiwiPrincipal/BotoesPrincipais/Linguagem")
onready var opcaoKiwiBotaoPrincipalSair = get_node("OpcoesKiwiPrincipal/BotoesPrincipais/Sair")

# SUBMENU
# --------------------------------- Video ------------------------------------
onready var opcaoKiwiBotaoVideoSuavisa = get_node("OpcoesKiwiVideo/BotoesDeVideo/Suavisar")
onready var opcaoKiwiBotaoVideoResolucao = get_node("OpcoesKiwiVideo/BotoesDeVideo/Resolucao")
onready var opcaoKiwiBotaoVideoSair = get_node("OpcoesKiwiVideo/BotoesDeVideo/Sair")

# --------------------------------- Controle ------------------------------------
onready var opcaoKiwiBotaoControleTeclado = get_node("OpcoesKiwiControle/BotoesDeControle/Teclado")
onready var opcaoKiwiBotaoControleControle = get_node("OpcoesKiwiControle/BotoesDeControle/Controle")
onready var opcaoKiwiBotaoControleSair = get_node("OpcoesKiwiControle/BotoesDeControle/Sair")

# --------------------------------- Linguagem ------------------------------------
onready var opcaoKiwiBotaoLinguagemPortugues = get_node("OpcoesKiwiLinguagem/BotoesDeLinguagem/Portugues")
onready var opcaoKiwiBotaoLinguagemIngles = get_node("OpcoesKiwiLinguagem/BotoesDeLinguagem/Ingles")
onready var opcaoKiwiBotaoLinguagemEspanhol = get_node("OpcoesKiwiLinguagem/BotoesDeLinguagem/Espanhol")
onready var opcaoKiwiBotaoLinguagemSair = get_node("OpcoesKiwiLinguagem/BotoesDeLinguagem/Sair")

# ------------------------- BOTOES - DOIS JOGADORES -----------------------------
# --------------------------------- Principal ------------------------------------
onready var opcaoDoisBotaoPrincipalVideo = get_node("OpcoesDoisPrincipal/BotoesPrincipais/Video")
onready var opcaoDoisBotaoPrincipalControle = get_node("OpcoesDoisPrincipal/BotoesPrincipais/Controle")
onready var opcaoDoisBotaoPrincipalLinguagem = get_node("OpcoesDoisPrincipal/BotoesPrincipais/Linguagem")
onready var opcaoDoisBotaoPrincipalSair = get_node("OpcoesDoisPrincipal/BotoesPrincipais/Sair")

# SUBMENU
# --------------------------------- Video ------------------------------------
onready var opcaoDoisBotaoVideoSuavisa = get_node("OpcoesDoisVideo/BotoesDeVideo/Suavisar")
onready var opcaoDoisBotaoVideoResolucao = get_node("OpcoesDoisVideo/BotoesDeVideo/Resolucao")
onready var opcaoDoisBotaoVideoSair = get_node("OpcoesDoisVideo/BotoesDeVideo/Sair")
# --------------------------------- Controle ------------------------------------
onready var opcaoDoisBotaoControleTeclado = get_node("OpcoesDoisControle/BotoesDeControle/Teclado")
onready var opcaoDoisBotaoControleControle = get_node("OpcoesDoisControle/BotoesDeControle/Controle")
onready var opcaoDoisBotaoControleSair = get_node("OpcoesDoisControle/BotoesDeControle/Sair")
# --------------------------------- Linguagem ------------------------------------
onready var opcaoDoisBotaoLinguagemPortugues = get_node("OpcoesDoisLinguagem/BotoesDeLinguagem/Portugues")
onready var opcaoDoisBotaoLinguagemIngles = get_node("OpcoesDoisLinguagem/BotoesDeLinguagem/Ingles")
onready var opcaoDoisBotaoLinguagemEspanhol = get_node("OpcoesDoisLinguagem/BotoesDeLinguagem/Espanhol")
onready var opcaoDoisBotaoLinguagemSair = get_node("OpcoesDoisLinguagem/BotoesDeLinguagem/Sair")

# =================================================================================
################################## Iniciar #########################################
# =================================================================================

# --------------------------------- GERAL --------------------------------------
onready var iniciarBotoes = get_node("Iniciar/Botoes")
onready var iniciarTexto = get_node("Iniciar/Texto")

# ---------------------------------- Iniciar -----------------------------------
onready var iniciarBotaoNovoJogo = get_node("Iniciar/Botoes/NovoJogo")
onready var iniciarBotaoCarregar = get_node("Iniciar/Botoes/Carregar")
onready var iniciarBotaoSair = get_node("Iniciar/Botoes/Sair")

# =================================================================================
################################# Carregamento ####################################
# =================================================================================
onready var carregarBotaoSair = get_node("CarregarJogo/Botoes/Sair")
onready var carregarBotaoCarga1 = get_node("CarregarJogo/BotoesCarregamento/Carregar1")
onready var carregarBotaoCarga2 = get_node("CarregarJogo/BotoesCarregamento/Carregar2")
onready var carregarBotaoCarga3 = get_node("CarregarJogo/BotoesCarregamento/Carregar3")
onready var carregarBotaoCarga4 = get_node("CarregarJogo/BotoesCarregamento/Carregar4")

# =================================================================================
################################## Salas #########################################
# =================================================================================

# ------------------------------ Botoes Principais --------------------------------
onready var salaBotaoSair = get_node("Salas/Botoes/Sair")
onready var salaBotaoCriar = get_node("Salas/Botoes/Criar")
onready var salaBotaoApagar = get_node("Salas/Botoes/Apagar")

# ------------------------------ Textos de Saida --------------------------------
onready var saidaDeTextoSala1 = get_node("Salas/ListaDeSalas/Sala1")
onready var saidaDeTextoSala2 = get_node("Salas/ListaDeSalas/Sala2")
onready var saidaDeTextoSala3 = get_node("Salas/ListaDeSalas/Sala3")
onready var saidaDeTextoSala4 = get_node("Salas/ListaDeSalas/Sala4")

# ------------------------------ Textos de Entrada --------------------------------
onready var entradaDeTextoSalas = get_node("Salas/nomeDaSala")

## =================================================================================
################################## Salvar jogo #####################################
## =================================================================================
#
## ------------------------------ Botoes Principais --------------------------------
#onready var salvarBotaoSalvar = get_node("SalvarJogo/Botoes/Salvar")
#onready var salvarBotaoApagar = get_node("SalvarJogo/Botoes/Apagar")
#onready var salvarBotaoSair = get_node("SalvarJogo/Botoes/Sair")
#
## ------------------------------ Textos de Saida --------------------------------
#onready var saidaDeTextoSalve1 = get_node("SalvarJogo/ListaDeJogosSalvos/Salve1")
#onready var saidaDeTextoSalve2 = get_node("SalvarJogo/ListaDeJogosSalvos/Salve2")
#onready var saidaDeTextoSalve3 = get_node("SalvarJogo/ListaDeJogosSalvos/Salve3")
#onready var saidaDeTextoSalve4 = get_node("SalvarJogo/ListaDeJogosSalvos/Salve4")
#
## ------------------------------ Textos de Entrada --------------------------------
#onready var entradaDeTextoSalves = get_node("SalvarJogo/nomeDoSalve")

############# JOGADORES
var dindi = false
var kiwi = false
var doisPlayers = false

var subMenus = false

func _ready():
	pass
	
func _physics_process(delta):
	if subMenus == false:
		umJogador()
		DoisJogadores()
	if subMenus == true:
		Remoto()
		Opcoes()
		Iniciar()
		CarregarJogo()
		Salas()
	
func umJogador():
	################## KIWI #####################
	if Global.entradaMenuUmJogadorKiwi == true:
		kiwi = true
		umJogadorPrincipalKiwi.show()
		if botaoInicioUmJogadorKiwi.pressed == true:
			umJogadorPrincipalKiwi.hide()
			Global.entradaMenuUmJogadorKiwi = false
			Global.saidaMenuUmJogadorKiwi = false
			iniciarPrincipal.show()
			
			subMenus = true
			
		if botaoOpcaoUmJogadorKiwi.pressed == true:
			umJogadorPrincipalKiwi.hide()
			Global.entradaMenuUmJogadorKiwi = false
			Global.saidaMenuUmJogadorKiwi = false
			###
			umJogadorPrincipalKiwi.hide()
			opcaoKiwiPrincipal.show()
			
			subMenus = true
			
		if botaoSairUmJogadorKiwi.pressed == true:
			umJogadorPrincipalKiwi.hide()
			Global.entradaMenuUmJogadorKiwi = false
			Global.saidaMenuUmJogadorKiwi = true
			kiwi = false
			
	################# DINDI ####################
	if Global.entradaMenuUmJogadorDindi == true:
		dindi = true
		umJogadorPrincipalDindi.show()
		if botaoInicioUmJogadorDindi.pressed == true:
			umJogadorPrincipalDindi.hide()
			Global.entradaMenuUmJogadorDindi = false
			Global.saidaMenuUmJogadorDindi = false
			iniciarPrincipal.show()
			
			subMenus = true
			
		if botaoOpcaoUmJogadorDindi.pressed == true:
			umJogadorPrincipalDindi.hide()
			Global.entradaMenuUmJogadorDindi = false
			Global.saidaMenuUmJogadorDindi = false
			###
			umJogadorPrincipalDindi.hide()
			opcaoDindiPrincipal.show()
			
			subMenus = true
			
		if botaoSairUmJogadorDindi.pressed == true:
			umJogadorPrincipalDindi.hide()
			Global.entradaMenuUmJogadorDindi = false
			Global.saidaMenuUmJogadorDindi = true
			dindi = false
	
func DoisJogadores():
	if Global.entradaMenuDoisJogadores == true:
		doisPlayers = true
		doisJogadoresPrincipal.show()
		if botaoLocalDoisJogadores.pressed == true:
			doisJogadoresPrincipal.hide()
			Global.entradaMenuDoisJogadores = false
			Global.saidaMenuDoisJogadores = false
			iniciarPrincipal.show()
			subMenus = true
			
		if botaoRemotoDoisJogadores.pressed == true:
			doisJogadoresPrincipal.hide()
			Global.entradaMenuDoisJogadores = false
			Global.saidaMenuDoisJogadores = false
			
			remotoPrincipal.show()
			doisJogadoresPrincipal.hide()
			
			subMenus = true
			
		if botaoOpcoesDoisJogadores.pressed == true:
			doisJogadoresPrincipal.hide()
			Global.entradaMenuDoisJogadores = false
			Global.saidaMenuDoisJogadores = false
			###
			opcaoDoisJogadoresPrincipal.show()
			doisJogadoresPrincipal.hide()
			subMenus = true
			
		if botaoSairDoisJogadores.pressed == true:
			doisJogadoresPrincipal.hide()
			Global.entradaMenuDoisJogadores = false
			Global.saidaMenuDoisJogadores = true
			doisPlayers = false
	
func Remoto():
	# Principal
	if remotoBotaoSalas.pressed == true:
		remotoPrincipal.hide()
		salasOnlinePrincipal.show()
		doisJogadoresPrincipal.hide()
		# -------------------------------
		
	if remotoBotaoModos.pressed == true:
		remotoPrincipal.hide()
		remotoModos.show()
		doisJogadoresPrincipal.hide()
		# -------------------------------
		
	if remotoBotaoSair.pressed == true:
		remotoPrincipal.hide()
		doisJogadoresPrincipal.show()
		subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		# -------------------------------
		
	# Modos
	if remotoBotaoModosHistoria.pressed == true:
		remotoModos.hide()
		salasOnlinePrincipal.show()
		doisJogadoresPrincipal.hide()
		# -------------------------------
		
	if remotoBotaoModosBatalha.pressed == true:
		remotoModos.hide()
		salasOnlinePrincipal.show()
		doisJogadoresPrincipal.hide()
		# -------------------------------
		
	if remotoBotaoModosSair.pressed == true:
		remotoModos.hide()
		remotoPrincipal.show()
		# -------------------------------
		
func Opcoes():
	# KIWI
	if kiwi == true:
		# Menu Principal
		if opcaoKiwiBotaoPrincipalVideo.pressed == true:
			opcaoKiwiVideo.show()
			opcaoKiwiPrincipal.hide()
			
		if opcaoKiwiBotaoPrincipalControle.pressed == true:
			opcaoKiwiControle.show()
			opcaoKiwiPrincipal.hide()
			
		if opcaoKiwiBotaoPrincipalLinguagem.pressed == true:
			opcaoKiwiLinguagem.show()
			opcaoKiwiPrincipal.hide()
			
		if opcaoKiwiBotaoPrincipalSair.pressed == true:
			opcaoKiwiPrincipal.hide()
			umJogadorPrincipalKiwi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
			
		# Video
		if opcaoKiwiBotaoVideoSuavisa.pressed == true:
			pass
			
		if opcaoKiwiBotaoVideoResolucao.pressed == true:
			pass
			
		if opcaoKiwiBotaoVideoSair.pressed == true:
			opcaoKiwiVideo.hide()
			opcaoKiwiPrincipal.show()
	
		# Controle
		if opcaoKiwiBotaoControleTeclado.pressed == true:
			pass
		if opcaoKiwiBotaoControleControle.pressed == true:
			pass
		if opcaoKiwiBotaoControleSair.pressed == true:
			opcaoKiwiControle.hide()
			opcaoKiwiPrincipal.show()
		
		# Linguagem
		if opcaoKiwiBotaoLinguagemPortugues.pressed == true:
			pass
		if opcaoKiwiBotaoLinguagemIngles.pressed == true:
			pass
		if opcaoKiwiBotaoLinguagemEspanhol.pressed == true:
			pass
		if opcaoKiwiBotaoLinguagemSair.pressed == true:
			opcaoKiwiLinguagem.hide()
			opcaoKiwiPrincipal.show()
			
	# DINDI
	if dindi == true:
		# Menu Principal
		if opcaoDindiBotaoPrincipalVideo.pressed == true:
			opcaoDindiVideo.show()
			opcaoDindiPrincipal.hide()
			
		if opcaoDindiBotaoPrincipalControle.pressed == true:
			opcaoDindiControle.show()
			opcaoDindiPrincipal.hide()
			
		if opcaoDindiBotaoPrincipalLinguagem.pressed == true:
			opcaoDindiLinguagem.show()
			opcaoDindiPrincipal.hide()
			
		if opcaoDindiBotaoPrincipalSair.pressed == true:
			opcaoDindiPrincipal.hide()
			umJogadorPrincipalDindi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
			
		# Video
		if opcaoDindiBotaoVideoSuavisa.pressed == true:
			pass
			
		if opcaoDindiBotaoVideoResolucao.pressed == true:
			pass
			
		if opcaoDindiBotaoVideoSair.pressed == true:
			opcaoDindiVideo.hide()
			opcaoDindiPrincipal.show()
	
		# Controle
		if opcaoDindiBotaoControleTeclado.pressed == true:
			pass
		if opcaoDindiBotaoControleControle.pressed == true:
			pass
		if opcaoDindiBotaoControleSair.pressed == true:
			opcaoDindiControle.hide()
			opcaoDindiPrincipal.show()
		
		# Linguagem
		if opcaoDindiBotaoLinguagemPortugues.pressed == true:
			pass
		if opcaoDindiBotaoLinguagemIngles.pressed == true:
			pass
		if opcaoDindiBotaoLinguagemEspanhol.pressed == true:
			pass
		if opcaoDindiBotaoLinguagemSair.pressed == true:
			opcaoDindiLinguagem.hide()
			opcaoDindiPrincipal.show()
	
	# DOIS JOGADORES
	if doisPlayers == true:
		# Menu Principal
		if opcaoDoisBotaoPrincipalVideo.pressed == true:
			opcaoDoisJogadoresVideo.show()
			opcaoDoisJogadoresPrincipal.hide()
			
		if opcaoDoisBotaoPrincipalControle.pressed == true:
			opcaoDoisJogadoresControle.show()
			opcaoDoisJogadoresPrincipal.hide()
			
		if opcaoDoisBotaoPrincipalLinguagem.pressed == true:
			opcaoDoisJogadoresLinguagem.show()
			opcaoDoisJogadoresPrincipal.hide()
			
		if opcaoDoisBotaoPrincipalSair.pressed == true:
			opcaoDoisJogadoresPrincipal.hide()
			doisJogadoresPrincipal.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
			
		# Video
		if opcaoDoisBotaoVideoSuavisa.pressed == true:
			pass
			
		if opcaoDoisBotaoVideoResolucao.pressed == true:
			pass
			
		if opcaoDoisBotaoVideoSair.pressed == true:
			opcaoDoisJogadoresVideo.hide()
			opcaoDoisJogadoresPrincipal.show()
	
		# Controle
		if opcaoDoisBotaoControleTeclado.pressed == true:
			pass
		if opcaoDoisBotaoControleControle.pressed == true:
			pass
		if opcaoDoisBotaoControleSair.pressed == true:
			opcaoDoisJogadoresControle.hide()
			opcaoDoisJogadoresPrincipal.show()
		
		# Linguagem
		if opcaoDoisBotaoLinguagemPortugues.pressed == true:
			pass
		if opcaoDoisBotaoLinguagemIngles.pressed == true:
			pass
		if opcaoDoisBotaoLinguagemEspanhol.pressed == true:
			pass
		if opcaoDoisBotaoLinguagemSair.pressed == true:
			opcaoDoisJogadoresLinguagem.hide()
			opcaoDoisJogadoresPrincipal.show()
	
func Iniciar():
	if iniciarBotaoNovoJogo.pressed == true:
		get_tree().change_scene("res://Cenarios/parte1/Fase1_P1.tscn")
	if iniciarBotaoCarregar.pressed == true:
		pass
	if iniciarBotaoSair.pressed == true:
		if dindi == true:
			iniciarPrincipal.hide()
			umJogadorPrincipalDindi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if kiwi == true:
			iniciarPrincipal.hide()
			umJogadorPrincipalKiwi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if doisPlayers == true:
			iniciarPrincipal.hide()
			doisJogadoresPrincipal.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
	
func CarregarJogo():
	if carregarBotaoCarga1.pressed == true:
		pass
	if carregarBotaoCarga2.pressed == true:
		pass
	if carregarBotaoCarga3.pressed == true:
		pass
	if carregarBotaoCarga4.pressed == true:
		pass
	if carregarBotaoSair.pressed == true:
		if dindi == true:
			carregarJogoPrincipal.hide()
			umJogadorPrincipalDindi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if kiwi == true:
			carregarJogoPrincipal.hide()
			umJogadorPrincipalKiwi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if doisPlayers == true:
			carregarJogoPrincipal.hide()
			doisJogadoresPrincipal.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		
func Salas():
	if salaBotaoCriar.pressed == true:
		pass
	if salaBotaoApagar.pressed == true:
		pass
	if salaBotaoSair.pressed == true:
		if dindi == true:
			salasOnlinePrincipal.hide()
			umJogadorPrincipalDindi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if kiwi == true:
			salasOnlinePrincipal.hide()
			umJogadorPrincipalKiwi.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
		if doisPlayers == true:
			salasOnlinePrincipal.hide()
			doisJogadoresPrincipal.show()
			subMenus = false # Sem isso, o menu principal nao sai da tela quando na sala
	

	
	



