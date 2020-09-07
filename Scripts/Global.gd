#extends "res://Scripts/Players.gd"
extends Node

# ESSE E O SINGLETON - NELE E COLOCADA AS VARIAVEIS GLOBAIS
# VARIAVEIS GLOBAIS SAO AQUELAS QUE O CODIGO VAI PODE ACESSAR
# DE QUALQUER NO

# Itens
# DINDI
var dindiSementeAmarela = 0
var dindiSementeRoxa = 6
var dindiSementeVerde = 0
var dindiChaveAmarela = 0
var dindiChaveRoxa = 0

# KIWI
var kiwiSementeAmarela = 0
var kiwiSementeRoxa = 6
var kiwiSementeVerde = 0
var kiwiChaveAmarela = 0
var kiwiChaveRoxa = 0

# ENERGIAS - CONTROLA A ENERGIA
var estadoEnergiaDindi = 0
var estadoEnergiaKiwi = 0

# define o nome de que o inimigo encostou
var inimigoEncosta
var posicInimigoEncosta

# Informacoes de fases
var portaAbertaFase = false
var areaPorta = false

# Grupos e posicao
var grupoPlay
var posicaoDindi

#Variaveis de Posicao
var DindiPosic
var DindiRot

#Variaveis de Posicao
var KiwiPosic
var KiwiRot

# Bola - Quando levar tiro
var recebeBola = false


# NAVIGATIONMESH
var inicioAlvo = Vector3()
var fimAlvo = Vector3()
var caminhoSeguir = []

# POSICAO PIVO MOVIMENTO
var A
var B
var C
var D
var E
var F
var G
var H

# Usado para realizar a movimentacao entre os pivores.
# Sem ele, iniciado em 1, o pivor nao se move
var contadorPivo = 1

# Esse eu não sei - SE LOCALIZAR, COLOCAR AQUI O SIGNIFICADO
var contador = 0

## ESSAS SAO AS ZONAS DA MORTE - NO MAXIMO 4 POR FASE
# ZONA DA MORTE 0
var zonaMorte = false
var zonaMorteNome
var zonaMorteDindi
var zonaMorteKiwi

# ZONA DA MORTE 1
var zonaMorte1 = false
var zonaMorteNome1
var zonaMorteDindi1
var zonaMorteKiwi1

# ZONA DA MORTE 2
var zonaMorte2 = false
var zonaMorteNome2
var zonaMorteDindi2
var zonaMorteKiwi2

# ZONA DA MORTE 3
var zonaMorte3 = false
var zonaMorteNome3
var zonaMorteDindi3
var zonaMorteKiwi3
###var zonaMorte = 0

# ESSA ESCOLHA DEVE ESTA NA TELA INICIAL
# Escolhado dos Players
# Estados da variavel:
# 1 = 1 player
# 2 = 2 players
var quantPlayers = 2

# Define qual player vai querer
# OBS: Essas escolha so e permitida, se for jogar com um jogador
# Estados da variavel:
# 1 = Dindi
# 2 = Kiwi
var DefinirPlayer = 1

# ISSO COLETA DADOS DE COLISAO DA BOLA
var colidioAlvo
var nomeColisaoBola
#var colidioAlvo = 0
var somSementeAmarelaColidio = false

# ISSO COLETA DADOS DE COLISAO DA BOLA INFINITA
var colidioAlvoInfi
var nomeColisaoBolaInfi

# SEMENTES
var nomeColisaoSemente
var somSementeInfinitaColidio = false

# Chave
var nomeColisaoChave

###########################################################
# Existe 5 scripts diferentes para solucionar o problema 
# Teletransporte
var teleportArea1 = false # Se entra na area, se torna true
var teleportDestino1 # Define o local de destino
var teleportNome1

var teleportArea2 = false # Se entra na area, se torna true
var teleportDestino2 # Define o local de destino
var teleportNome2

var teleportArea3 = false # Se entra na area, se torna true
var teleportDestino3 # Define o local de destino
var teleportNome3

var teleportArea4 = false # Se entra na area, se torna true
var teleportDestino4 # Define o local de destino
var teleportNome4

var teleportArea5 = false # Se entra na area, se torna true
var teleportDestino5 # Define o local de destino
var teleportNome5

#########################################################

# Buraco da Morte - PODE SER UTILIZADO EM OUTRAS SITUACOES
var buracoMorte = false # Se acionado, o personagem morre
var buracoMorteNome

# Quando a morte enconsta
var morteEncostaDindi = false
var morteEncostaKiwi = false
var morteNomeDindi
var morteNomeKiwi

# Botao de Acionar
var botaoVermelho = false
var botaoArmadilha = false

# Botao gato - nariz
var acionouBotao = false

# TEMPORIZADOR
var unidade = 0
var dezena = 0
var centena = 0

var fimTempo = false

### ANIMACOES DE INIMIGOS -  VARIAVEIS ####


# EFEITOS SONOROS

var somAndandoPedras = false
var somMorte = false
var somPuloDindi = false
var somPuloKiwi = false
var somVento = false
var somAbrirPortaMadeira = false
var somAbrirPortaMetal = false
var somAlacanca = false
var somArrastaObjeto1 = false
var somArrastaObjeto2 = false
var somArrastaObjeto3 = false
var somBalancaArvore1 = false
var somBalancaArvore2 = false
var somBalancaArvore3 = false

var somColisaoAmarelaCorpo = false
var somColisaoAmarelaMadeira = false
var somColisaoAmarelaRocha = false
var somColisaoAmarelaVidro = false
var somColisaoAmarelaMetal = false

var somColisaoAzulCorpo = false
var somColisaoAzulMadeira = false
var somColisaoAzulRocha = false
var somColisaoAzulVidro = false
var somColisaoAzulMetal = false

var somBolhaLentas = false
var somBolhasRapidas = false
var somBotaoGato = false
var somBotaoPoso = false
var somChuteBota = false
var somChuva = false
var somColetaChaveAmarela = false
var somColetaChaveRoxa = false
var somColetaSementeAmarela = false
var somColetaSementeVerde = false
var somColetaSementeRoxa = false
var somJogarSementeAmarela = false
var somJogarSementeAzul = false
var somLocalColeta = false
var somNaturezaComChuva = false
var somNaturezaSemChuva = false
var somPalhacoEmpurraSoco = false
var somPisoTeletransporte = false
var somRodaGirando = false
var somTeletransporte = false

# LINGUAGEM
var ingles = false
var portugues = false
var espanhol = false

# ENTRADA E SAIDA NOS SUBMENUS NO MENU PRINCIPAL
var entradaMenuUmJogadorKiwi = false
var entradaMenuUmJogadorDindi = false
var entradaMenuDoisJogadores = false

var saidaMenuUmJogadorKiwi = false
var saidaMenuUmJogadorDindi = false
var saidaMenuDoisJogadores = false

# PORTA DA SAIDA DE FASE
var portaDeTrocaDeFase = false


############## FASES
var f1_p1 = false
var f2_p1 = false
var f3_p1 = false
var f4_p1 = false
var f5_p1 = false
var f6_p1 = false
var f7_p1 = false
var f8_p1 = false
var f9_p1 = false

var f1_p2 = false
var f2_p2 = false
var f3_p2 = false
var f4_p2 = false
var f5_p2 = false
var f6_p2 = false

var f1_p3 = false
var f2_p3 = false
var f3_p3 = false
var f4_p3 = false

#### DANOS
var dindiEncostaInimigo = false
var kiwiEncostaInimigo = false

