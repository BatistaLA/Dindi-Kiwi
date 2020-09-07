extends Area
#extends RigidBody

var speed = 25
var speed_inimigo = 1000
var velocity = Vector3()

# Essa funcao e para o jogador
func start(xform):
	transform = xform
	velocity = -transform.basis.z * speed
	
# Essa funcao e para o inimigo
func start_inimigo(xform, delta):
	transform = xform
	velocity = -transform.basis.z * speed_inimigo * delta

# Esse e o loop inicial - MAIN LOOP
func _process(delta):
	transform.origin += velocity * delta

# Funcao do tempo de duracao do tiro
func _on_Timer_timeout():
	queue_free()

# Sinal emitido, quando a area colidir
func _on_Bola_Tiro_body_entered(body):
	var rocha = body.is_in_group("rocha")
	var madeira = body.is_in_group("madeira")
	var vidro = body.is_in_group("vidro")
	var metal = body.is_in_group("metal")
	
	if rocha == true:
		Global.somColisaoAzulRocha = true
		queue_free()
	if madeira == true:
		Global.somColisaoAzulMadeira = true
		queue_free()
	if vidro == true:
		Global.somColisaoAzulVidro = true
		queue_free()
	if metal == true:
		Global.somColisaoAzulMetal = true
		queue_free()
		
	if body is StaticBody:
		queue_free()
			
	if body is KinematicBody: 
		Global.somColisaoAzulCorpo = true # Quando bate em um corpo
		queue_free()

	# Isso ajuda coleta as informacoes da colisao - PODE ESTA ERRADA(DEVE SER SEM O IF)
	if get_tree().get_nodes_in_group("inimigo"):
		# ISSO VAI PEGAR A POSICAO DO ALVO, ONDE A BOLA COLIDIU
		# ERA O QUE ESTAVA FALTANDO!!! AMEM SENHOR!!!
		Global.colidioAlvoInfi = body.transform.origin
		Global.nomeColisaoBolaInfi = body.name
		#print("Inimigo recebe tiro: ", Global.colidioAlvo)
		#print("Bola inimigoPosico: ", body.transform.origin)
		#Global.colidioAlvo += 1
