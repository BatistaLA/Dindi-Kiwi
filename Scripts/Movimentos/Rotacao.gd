extends Spatial

func _physics_process(delta):
#	global_rotate(Vector3)
	global_translate(Vector3(0, 8, 0) * delta)
