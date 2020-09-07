extends Spatial

var botaoAciona = false
onready var botaoAnin = $AnimationPlayer
var nome

func _physics_process(delta):
	if botaoAciona == true:
		botaoAnin.play("acionar")
		Global.botaoVermelho = false

func _on_Area_body_entered(body):
	nome = body.name
	if nome == "PlayerDindi":
		botaoAciona = true
		Global.botaoVermelho = true
		
	if nome == "PlayerKiwi":
		botaoAciona = true
		Global.botaoVermelho = true
