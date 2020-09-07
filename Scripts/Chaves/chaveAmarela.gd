extends Area

func _ready():
	pass

func _on_chaveAmarela_body_entered(body):
	Global.nomeColisaoChave = body.name
	if get_tree().get_nodes_in_group("players"):
		if Global.nomeColisaoChave == "PlayerDindi":
			Global.somColetaChaveAmarela = true
			Global.dindiChaveAmarela += 1
			queue_free()
		if Global.nomeColisaoChave == "PlayerKiwi":
			Global.somColetaChaveAmarela = true
			Global.kiwiChaveAmarela += 1
			queue_free()
