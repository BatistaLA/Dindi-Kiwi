extends Spatial

func _ready():
	pass

func _physics_process(delta):
	if Global.portaDeTrocaDeFase == true:
		Global.f7_p1 = true
		get_tree().change_scene("res://Cenarios/parte1/Fase8_P1.tscn")
		Global.portaDeTrocaDeFase  = false

