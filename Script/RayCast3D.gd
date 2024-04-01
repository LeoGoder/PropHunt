extends RayCast3D

var collider
func _process(delta):
	if is_colliding():
		if Input.is_action_just_pressed("Transfo"):
			collider = get_collider()
			collider.GetID()
			$"..".ChangePlayer()

