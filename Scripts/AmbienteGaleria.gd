extends WorldEnvironment

func _physics_process(delta):
	rotacao(delta)
	
func rotacao(delta):
	environment.background_sky_rotation += Vector3(0,0.08,0) * delta

