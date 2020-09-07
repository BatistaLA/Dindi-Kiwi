extends Spatial

var entraArea = false
var destino
var nome

func _ready():
	destino = get_node("Destino").global_transform.origin
	
func _physics_process(delta):
	destino = get_node("Destino").global_transform.origin
	enviaMensagem()
	
func enviaMensagem():
	if entraArea == true:
		Global.teleportArea1 = true
		Global.teleportDestino1 = destino
#		entraArea = false
	if entraArea == false:
		Global.teleportArea1 = false

# Entrou na area
func _on_Buraco_body_entered(body):
	nome = body.name
	if nome == "PlayerDindi":
		entraArea = true
		Global.teleportNome1 = "Dindi"
		
	if nome == "PlayerKiwi":
		entraArea = true
		Global.teleportNome1 = "Kiwi"
	
# Saiu da area
func _on_Buraco_body_exited(body):
	nome = body.name
	if nome == "PlayerDindi":
		entraArea = false

	if nome == "PlayerKiwi":
		entraArea = false
