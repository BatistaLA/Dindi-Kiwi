extends Spatial

onready var animacaoPorta = $PortaMetal/AnimationPlayer
onready var labelBalao = get_node("BalaoMensagem/FundoObjeto/texto_pt_BR")
onready var balaoMsg = get_node("BalaoMensagem/FundoObjeto")

var entrada = false
var nomeEntrou
var portaAberta = false
var balaoVistaDindi = 1
var balaoVistakiwi = 1
#var textoBalao = "    Para abrir a porta, \n você deverá encontrar \n a chave amarela. Essa \n chave está  no meio dos \n monstros."

func _ready():
	entrada = 1
	labelBalao.hide()
	balaoMsg.hide()
	entrada = false
	
func _process(delta):
	Global.portaAbertaFase = portaAberta
	Global.areaPorta = entrada
	
	# Funcao de abrir porta
	abrirPorta()
	
	# Funcao de decisao de balao
	dedisaoBalao()
	
#	# Funcao de mensagem - define a mensagem
#	mensagem()

func abrirPorta():
	if entrada == true and portaAberta == false:
		if nomeEntrou == "PlayerDindi" and Global.dindiChaveRoxa > 0:
			if Input.is_action_just_pressed("selecionar_dindi"):
				Global.dindiChaveRoxa -= 1
				animacaoPorta.play("Abrir")
				portaAberta = true
		if nomeEntrou == "PlayerKiwi" and Global.kiwiChaveRoxa > 0:
			if Input.is_action_just_pressed("selecionar_kiwi"):
				Global.kiwiChaveRoxa -= 1
				animacaoPorta.play("Abrir")
				portaAberta = true
				
	if entrada == true and portaAberta == false:
		if Input.is_action_just_pressed("selecionar_dindi"):
			balaoVistaDindi += 1
		if Input.is_action_just_pressed("selecionar_kiwi"):
			balaoVistakiwi += 1
			
	if Global.acionouBotao == true:
		animacaoPorta.play("Abrir")
		portaAberta = true
		Global.acionouBotao = false
			
# Isso realiza a decisao de liga e desliga balao
func dedisaoBalao():
	if portaAberta == false:
		if balaoVistaDindi == 2:
			labelBalao.show()
			balaoMsg.show()
		if balaoVistaDindi == 3:
			labelBalao.hide()
			balaoMsg.hide()
			balaoVistaDindi = 1
		
		if balaoVistakiwi == 2:
			labelBalao.show()
			balaoMsg.show()
		if balaoVistakiwi == 3:
			labelBalao.hide()
			balaoMsg.hide()
			balaoVistakiwi = 1
		
	if entrada == false:
		labelBalao.hide()
		balaoMsg.hide()
		


#func mensagem():
#	get_node("BalaoMensagem/FundoObjeto/Texto").set_text(textoBalao)


# Quando entrar na area da porta
func _on_perto_body_entered(body):
	nomeEntrou = body.name
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			entrada = true
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			entrada = true
	
# Quando sair da area da porta
func _on_perto_body_exited(body):
	if get_tree().get_nodes_in_group("dindi"):
		if nomeEntrou == "PlayerDindi":
			entrada = false
	if get_tree().get_nodes_in_group("kiwi"):
		if nomeEntrou == "PlayerKiwi":
			entrada = false

