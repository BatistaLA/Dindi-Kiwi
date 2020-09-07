extends Area

# Essa funcao e utilizada apenas quando necessaria
# Ela define uma area, que, quando o player colidir, ela emite um sinal, 
# informando que entrou na zona da morte.
# Isso pode ser utilizado para realizar alguma acao

func _ready():
	# Inicial deve ser false
	Global.zonaMorte = false
	pass

# Ao entrar
func _on_ZonadaMorte_body_entered(body):
	Global.zonaMorteNome = body.name
#	print(self.name)
	if get_tree().get_nodes_in_group("players"):
		if Global.zonaMorteNome == "PlayerDindi":
			Global.zonaMorteDindi = "PlayerDindi"
			Global.zonaMorte = true
		if Global.zonaMorteNome == "PlayerKiwi":
			Global.zonaMorteKiwi = "PlayerKiwi"
			Global.zonaMorte = true
		#print("Entrou", Global.zonaMorte)

# Ao sair
func _on_ZonadaMorte_body_exited(body):
	Global.zonaMorteNome = body.name
	if get_tree().get_nodes_in_group("players"):
		if Global.zonaMorteNome == "PlayerDindi":
			Global.zonaMorteDindi = null
			Global.zonaMorte = false
		if Global.zonaMorteNome == "PlayerKiwi":
			Global.zonaMorteKiwi = null
			Global.zonaMorte = false
		#print("saiu", Global.zonaMorte)
