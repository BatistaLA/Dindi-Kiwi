extends Node2D

# Animacao
onready var aniUnidade = $segundosUnidade
onready var aniDezena = $segundosDezenas
onready var aniCentena = $segundosCentenas

# Tempo de decrescimo
var tempoDec = 102
var unidade = 0
var dezena = 0
var centena = 0
var stringTempo = []

# Tempo
onready var tempo = $Timer
var tempoConta = 1
var tempoGatilho = false

func _ready():
	tempoGatilho = true
	
func _physics_process(delta):
	
	converterTempo() # Controla o tempo
	frameAnime() # Controla a animacao
	fimTempo() # Quando o tempo acaba, mata os personagens e chama outro quadro
	
# Isso faz a contagem do tempo  - voltando
func converterTempo():
	stringTempo = str(tempoDec)
	if tempoDec >= 100:
		unidade = int(stringTempo[2])
		dezena = int(stringTempo[1])
		centena = int(stringTempo[0])
	if tempoDec < 100 and tempoDec >= 10:
		unidade = int(stringTempo[1])
		dezena = int(stringTempo[0])
		centena = 0
	if tempoDec < 10:
		unidade = int(stringTempo[0])
		dezena = 0
		centena = 0
	if tempoDec == 0:
		unidade = 0
		dezena = 0
		centena = 0
		
func frameAnime():
	aniUnidade.play(str(unidade))
	aniDezena.play(str(dezena))
	aniCentena.play(str(centena))
		
func fimTempo():
	if tempoConta == 0:
		Global.fimTempo = true
		
func _on_Timer_timeout():
	$Timer.wait_time = 1
	tempoDec -= tempoConta
#	if tempoGatilho == true:
#		tempoConta -= tempoDec
#		tempoGatilho = false
