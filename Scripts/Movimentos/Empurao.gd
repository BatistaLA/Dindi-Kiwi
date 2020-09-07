extends Spatial

export var velocidade = 0
var posicAtual = Vector3()
export var posicDestino = Vector3(0, 0, 0)
var posicInicial = Vector3()
var posicFinal = Vector3()

var nome

var locomocao = false

func _ready():
	posicInicial = global_transform.origin
	posicFinal = posicDestino

func _physics_process(delta):
	posicAtual = global_transform.origin
	posicFinal = posicInicial + posicDestino
	
	
	if posicAtual == posicInicial:
		locomocao = false
		
	if posicAtual <= posicInicial:
		locomocao = false
		
	if posicAtual >= posicFinal:
		locomocao = true
	
	if locomocao == false:
		global_translate(posicDestino * delta)

	if locomocao == true: 
		global_translate(-posicDestino * velocidade * delta)
		

func _on_Area_body_entered(body):
	nome = body.name
	if nome == "PlayerDindi":
		Global.buracoMorteNome = "Dindi"
		Global.buracoMorte = true

	if nome == "PlayerKiwi":
		Global.buracoMorteNome = "Kiwi"
		Global.buracoMorte = true

