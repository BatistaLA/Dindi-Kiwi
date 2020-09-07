extends Spatial

onready var olhos1 = $OlhosBotoes1
onready var olhos2 = $OlhosBotoes2
onready var botaoAnimacao = $AnimationPlayer

# Posicao alvo
var posicAlvo

# Area - entrada
var nomeEntrou
var entrada
var entradaBotao

# Quando o botao for apertado
var botaoApertado = false
var olho1PosicInicial
var olho2PosicInicial

var botaoJaFoiApertado = false

# Escolha do personagem
# 1 - Dindi
# 2 - Kiwi
var playeEscolha = 1

func _ready():
	posicAlvo = Vector3(1, 1 , 1)
	entrada = false
	olho1PosicInicial = olhos1.transform.origin
	olho2PosicInicial = olhos2.transform.origin
	
	randomize() 
	
func _physics_process(delta):
	olhosApontando(delta)
	apertarBotao()
	escolhaPlay()
	
# Olha para o personagem
func olhosApontando(delta):
	if entrada == true and entradaBotao == false:
		# Isso faz com que ele olhe para o player
		olhos1.look_at(posicAlvo, Vector3(0, 1, 0) * delta)
		olhos2.look_at(posicAlvo, Vector3(0, 1, 0) * delta)
		
		# Isso reseta a escala - Tem que ser nessa ordem, senao nao funciona
		olhos1.global_scale(Vector3(0.43, 0.407, 0.371))
		olhos2.global_scale(Vector3(0.43, 0.407, 0.371))
		
	if entrada == true and entradaBotao == true:
		# Isso faz com que ele olhe para o player
		olhos1.look_at(olho1PosicInicial, Vector3(0, 1, 0) * delta)
		olhos2.look_at(olho2PosicInicial, Vector3(0, 1, 0) * delta)
		
		# Isso reseta a escala - Tem que ser nessa ordem, senao nao funciona
		olhos1.global_scale(Vector3(0.43, 0.407, 0.371))
		olhos2.global_scale(Vector3(0.43, 0.407, 0.371))
		
# Ao apertar o botao, ela sera acionada, se estiver na area
func apertarBotao():
	if entradaBotao == true and botaoApertado == false:
		if botaoJaFoiApertado == false:
			if Input.is_action_just_pressed("selecionar_dindi"):
				botaoAnimacao.play("apertar")
				botaoApertado = true
				Global.acionouBotao = true
				botaoJaFoiApertado = true
			if Input.is_action_just_pressed("selecionar_kiwi"):
				botaoAnimacao.play("apertar")
				botaoApertado = true
				Global.acionouBotao = true
				botaoJaFoiApertado = true

func escolhaPlay():
	if playeEscolha == 1:
		posicAlvo = Global.DindiPosic
	if playeEscolha == 2:
		posicAlvo = Global.KiwiPosic
	

func _on_Area_body_entered(body):
	nomeEntrou = body.name
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			playeEscolha = 1
			entrada = true
			
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			playeEscolha = 2
			entrada = true

func _on_Area_body_exited(body):
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			entrada = false
			
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			entrada = false

# Esse e apeans para o botao
func _on_AreaBotao_body_entered(body):
	nomeEntrou = body.name
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			entradaBotao = true
			
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			entradaBotao = true


func _on_AreaBotao_body_exited(body):
	nomeEntrou = body.name
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			entradaBotao = false
			
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			entradaBotao = false
