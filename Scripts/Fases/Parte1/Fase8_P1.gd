extends Spatial

func _ready():
	pass

func _physics_process(delta):
	if Global.portaDeTrocaDeFase == true:
		Global.f8_p1 = true
		get_tree().change_scene("res://Cenarios/parte1/Fase9_P1_F.tscn")
		Global.portaDeTrocaDeFase  = false
