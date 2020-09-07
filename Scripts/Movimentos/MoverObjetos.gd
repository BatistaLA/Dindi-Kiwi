extends MeshInstance

export var velocidade = 0
var posicAtual = Vector3()
export var posicDestino = Vector3(0, 0, 0)
var posicInicial = Vector3()
var posicFinal = Vector3()

var locomocao = false

func _ready():
	posicInicial = global_transform.origin
	posicFinal = posicDestino

func _physics_process(delta):
	posicAtual = global_transform.origin
	posicFinal = posicInicial + posicDestino
	
	# Se for acionado o interruptor, o objeto sera movido
	if Global.acionouBotao == true:
		locomocao = true
	
# Movimenta o objetos se locomocao for true
	if locomocao == true: 
		global_translate(-posicDestino * delta)
		