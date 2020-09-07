extends Area

func _ready():
	pass


func _on_chaveAmarela_body_entered(body):
	Global.nomeColisaoChave = body.name
	if get_tree().get_nodes_in_group("players"):
		if Global.nomeColisaoChave == "PlayerDindi":
			Global.somColetaChaveRoxa = true
			Global.dindiChaveRoxa += 1
			queue_free()
		if Global.nomeColisaoChave == "PlayerKiwi":
			Global.somColetaChaveRoxa = true
			Global.kiwiChaveRoxa += 1
			queue_free()
