extends Area

func _ready():
	# A coleta dos locais onde se encontram os pivos e realizada ao iniciar o jogo
	# Tudo e armazenado em variaveis separadas em outros script, com o singleton
	Global.A = get_node("A").global_transform.origin
	Global.B = get_node("B").global_transform.origin
	Global.C = get_node("C").global_transform.origin
	Global.D = get_node("D").global_transform.origin
	Global.E = get_node("E").global_transform.origin
	Global.F = get_node("F").global_transform.origin
	Global.G = get_node("G").global_transform.origin
	Global.H = get_node("H").global_transform.origin
	

# Quando colidido na area, o contador soma 1
func _on_Pivo_body_entered(body):
	# Se o inimigos for do grupo inimigos, soma 1 ao contador
	
	if get_tree().get_nodes_in_group("inimigo"):
		Global.contadorPivo += 1
