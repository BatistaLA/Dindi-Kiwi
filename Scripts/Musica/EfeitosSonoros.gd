extends Spatial

# SOM - EFEITOS (ALTERAR APENAS AQUI)
onready var somAndandoPedras = $AndandosNasPedras

onready var somMorte = $Morte

onready var somPuloDindi = $PuloDindi
onready var somPuloKiwi = $PuloKiwi

onready var somVento = $Vento
onready var somChuva = $chuva
onready var somNaturezaComChuva = $naturezaComChuva
onready var somNaturezaSemChuva = $naturezaSemChuva

onready var somAbrirPortaMadeira = $abrirPortaMadeira
onready var somAbrirPortaMetal = $abrirPortaMetal

onready var somAlacanca = $alavanca

onready var somArrastaObjeto1 = $arrastandoObjetos
onready var somArrastaObjeto2 = $arrastandoObjetos2
onready var somArrastaObjeto3 = $arrastandoObjetos3

onready var somBalancaArvore1 = $balancaArvore1
onready var somBalancaArvore2 = $balancaArvore2
onready var somBalancaArvore3 = $balancaArvore3

onready var somColisaoAmarelaCorpo = $batidaSementeAmarelaCorpo
onready var somColisaoAmarelaMadeira = $batidaSementeAmarelaMadeira
onready var somColisaoAmarelaRocha = $batidaSementeAmarelaRocha
onready var somColisaoAmarelaVidro = $batidaSementeAmarelaVidro
onready var somColisaoAmarelaMetal = $batidaSementeAmarelaMetal

onready var somColisaoAzulCorpo = $batidaSementeAzulCorpo
onready var somColisaoAzulMadeira = $batidaSementeAzulMadeira
onready var somColisaoAzulRocha = $batidaSementeAzulRocha
onready var somColisaoAzulVidro = $batidaSementeAzulVidro
onready var somColisaoAzulMetal = $batidaSementeAzulMetal

onready var somBolhaLentas = $bolhasLentas
onready var somBolhasRapidas = $bolhasRapidas

onready var somBotaoGato = $botaoGato

onready var somBotaoPoso = $botaoPiso

onready var somChuteBota = $chuteBota

onready var somColetaChaveAmarela = $coletaChaveAmarela
onready var somColetaChaveRoxa = $coletaChaveRoxa

onready var somColetaSementeAmarela = $coletaSementeAmarela
onready var somColetaSementeVerde = $coletaSementeVerde
onready var somColetaSementeRoxa = $coletaSementeRoxa

onready var somJogarSementeAmarela = $jogarSementeAmarela
onready var somJogarSementeAzul = $jogarSementeAzul

onready var somLocalColeta = $localdeColeta

onready var somPalhacoEmpurraSoco = $palhacoEmpurraSoco

onready var somPisoTeletransporte = $pisoTeletransporte

onready var somRodaGirando = $rodaGirando

onready var somTeletransporte = $teletransporte

func _process(delta):
#	somEfeitosSonoros(somAndandoPedras, Global.somAndandoPedras)
#	somEfeitosSonoros(somMorte, Global.somMorte)
#	somEfeitosSonoros(somPuloDindi, Global.somPuloDindi)
#	somEfeitosSonoros(somPuloKiwi, Global.somPuloKiwi)
#	somEfeitosSonoros(somVento, Global.somVento)
#	somEfeitosSonoros(somAbrirPortaMadeira, Global.somAbrirPortaMadeira)
#	somEfeitosSonoros(somAbrirPortaMetal, Global.somAbrirPortaMetal)
#	somEfeitosSonoros(somArrastaObjeto1, Global.somArrastaObjeto1)
#	somEfeitosSonoros(somArrastaObjeto2, Global.somArrastaObjeto2)
#	somEfeitosSonoros(somArrastaObjeto3, Global.somArrastaObjeto3)
#	somEfeitosSonoros(somBalancaArvore1, Global.somBalancaArvore1)
#	somEfeitosSonoros(somBalancaArvore2, Global.somBalancaArvore2)
#	somEfeitosSonoros(somBalancaArvore3, Global.somBalancaArvore3)
#
	somEfeitosSonoros(somColisaoAmarelaCorpo, Global.somColisaoAmarelaCorpo)
	somEfeitosSonoros(somColisaoAmarelaMadeira, Global.somColisaoAmarelaMadeira)
	somEfeitosSonoros(somColisaoAmarelaRocha, Global.somColisaoAmarelaRocha)
	somEfeitosSonoros(somColisaoAmarelaVidro, Global.somColisaoAmarelaVidro)
	somEfeitosSonoros(somColisaoAmarelaMetal, Global.somColisaoAmarelaMetal)
#
	somEfeitosSonoros(somColisaoAzulCorpo, Global.somColisaoAzulCorpo)
	somEfeitosSonoros(somColisaoAzulMadeira, Global.somColisaoAzulMadeira)
	somEfeitosSonoros(somColisaoAzulRocha, Global.somColisaoAzulRocha)
	somEfeitosSonoros(somColisaoAzulVidro, Global.somColisaoAzulVidro)
	somEfeitosSonoros(somColisaoAzulMetal, Global.somColisaoAzulMetal)
#
#	somEfeitosSonoros(somBolhaLentas, Global.somBolhaLentas)
#	somEfeitosSonoros(somBolhasRapidas, Global.somBolhasRapidas)
#	somEfeitosSonoros(somBotaoGato, Global.somBotaoGato)
#	somEfeitosSonoros(somBotaoPoso, Global.somBotaoPoso)
#	somEfeitosSonoros(somChuteBota, Global.somChuteBota)
#	somEfeitosSonoros(somChuva, Global.somChuva)

#	somEfeitosSonoros(somColetaChaveAmarela, Global.somColetaChaveAmarela)
#	somEfeitosSonoros(somColetaChaveRoxa, Global.somColetaChaveRoxa)

	somEfeitosSonoros(somColetaSementeAmarela, Global.somColetaSementeAmarela)
	somEfeitosSonoros(somColetaSementeVerde, Global.somColetaSementeVerde)
	somEfeitosSonoros(somColetaSementeRoxa, Global.somColetaSementeRoxa)
	somEfeitosSonoros(somJogarSementeAmarela, Global.somJogarSementeAmarela)
	somEfeitosSonoros(somJogarSementeAzul, Global.somJogarSementeAzul)
#	somEfeitosSonoros(somLocalColeta, Global.somLocalColeta)
#	somEfeitosSonoros(somNaturezaComChuva, Global.somNaturezaComChuva)
#	somEfeitosSonoros(somNaturezaSemChuva, Global.somNaturezaSemChuva)
#	somEfeitosSonoros(somPalhacoEmpurraSoco, Global.somPalhacoEmpurraSoco)
#	somEfeitosSonoros(somPisoTeletransporte, Global.somPisoTeletransporte)
#	somEfeitosSonoros(somRodaGirando, Global.somRodaGirando)
#	somEfeitosSonoros(somTeletransporte, Global.somTeletransporte)

func somEfeitosSonoros(efeitoDeSom, efeitoDeSomGlobal):
	if efeitoDeSomGlobal == true:
		efeitoDeSom.play()
		efeitoDeSomGlobal = false
		print(efeitoDeSomGlobal)
		