extends Spatial

var nome
var direcao = -1
export var velocidadeAnima = 1
onready var animacaoPalhaco = $PalhacoSoco/AnimationPlayer


func _ready():
	pass

func _physics_process(delta):
#	rotacao(delta)
	animacaoPalhaco.playback_speed = velocidadeAnima
	animacaoPalhaco.play("PalhacoSocoAction")
	
# Rotacao nao muito boa
func rotacao(delta):
	var valorRotacao = int(rotation_degrees.y)
	var valorAnimTime = animacaoPalhaco.current_animation_position
	if valorRotacao != -270:
		rotation.y += direcao * delta
	if valorRotacao == -270 and valorAnimTime < 1.2:
		animacaoPalhaco.play("PalhacoSocoAction")
	if valorAnimTime >= 1.2:
		animacaoPalhaco.stop(true)
		rotation.y += direcao * delta
	if valorRotacao == -360:
		rotation.y = 0
		rotation.y += direcao * delta
	
		
	print(valorRotacao)

func _on_morte_body_entered(body):
	Global.inimigoEncosta = body.name


func _on_morte_body_exited(body):
	Global.inimigoEncosta = null
