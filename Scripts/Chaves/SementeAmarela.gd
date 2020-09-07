extends Area

func _ready():
	pass


# Essa funcao recebe a colisao do player - Se ele colidir, aumenta o valor do player e remove o objeto da cena
func _on_SementesColeta_body_entered(body):
	Global.nomeColisaoSemente = body.name
	if get_tree().get_nodes_in_group("players"):
		if Global.nomeColisaoSemente == "PlayerDindi":
			Global.somColetaSementeAmarela = true
			Global.dindiSementeAmarela += 10
			queue_free()
		if Global.nomeColisaoSemente == "PlayerKiwi":
			Global.somColetaSementeAmarela = true
			Global.kiwiSementeAmarela += 10
			queue_free()
		

