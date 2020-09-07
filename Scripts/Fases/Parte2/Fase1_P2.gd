extends Spatial

func _ready():
	pass

func _physics_process(delta):
	if Global.portaDeTrocaDeFase == true:
		Global.f1_p2 = true
		get_tree().change_scene("res://Cenarios/parte1/Fase2_P2.tscn")
		Global.portaDeTrocaDeFase  = false