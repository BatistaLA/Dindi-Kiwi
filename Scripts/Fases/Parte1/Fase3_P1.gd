extends Spatial

func _ready():
	pass

func _physics_process(delta):
	if Global.portaDeTrocaDeFase == true:
		Global.f3_p1 = true
		get_tree().change_scene("res://Cenarios/parte1/Fase4_P1.tscn")
		Global.portaDeTrocaDeFase  = false