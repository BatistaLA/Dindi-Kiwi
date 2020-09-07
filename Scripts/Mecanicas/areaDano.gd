extends Spatial

var nome

func _ready():
	pass

func _on_morte_body_entered(body):
	Global.inimigoEncosta = body.name

func _on_morte_body_exited(body):
	Global.inimigoEncosta = null
