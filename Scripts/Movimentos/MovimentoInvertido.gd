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
	
	
	if posicAtual == posicInicial:
		locomocao = true
		
	if posicAtual >= posicInicial:
		locomocao = true
		
	if posicAtual <= posicFinal:
		locomocao = false
	
	if locomocao == false:
		global_translate(-posicDestino * velocidade * delta)

	if locomocao == true: 
		global_translate(posicDestino * velocidade * delta)
		
#func _physics_process(delta):
#	global_translate(Vector3(2,0,0) * delta)