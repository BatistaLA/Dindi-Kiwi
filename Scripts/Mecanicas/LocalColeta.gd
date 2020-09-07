extends Spatial

var coleta = 0
var nome


func _on_Area_body_entered(body):
	nome = body.name
	if get_tree().get_nodes_in_group("objColeta"): # Esse nome ainda nao foi definido
		if nome == "Coleta": # Esse nome ainda nao foi definido
			coleta += 1 # Isso adiciona um valor na coleta
