extends GridContainer

onready var carregar = $BotaoCarregar
onready var Play = $BotaoPlay
onready var sair = $BotaoSair
onready var menu = $BotaoMenu

func _ready():
	pass
	
func _physics_process(delta):
	sairJogo() # Sai do jogo
	
	
func sairJogo():
	if sair.pressed == true:
		get_tree().quit()
	
func carregarJogo():
	pass
	
func menuJogo():
	pass
	
func iniciarJogo():
	pass
