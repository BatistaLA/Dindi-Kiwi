extends Spatial

var nome

func _on_Area_body_entered(body):
	nome = body.name
	if nome == "PlayerDindi":
		Global.buracoMorteNome = "Dindi"
		Global.buracoMorte = true
		
	if nome == "PlayerKiwi":
		Global.buracoMorteNome = "Kiwi"
		Global.buracoMorte = true
