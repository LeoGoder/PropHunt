extends Node3D



#func _physics_process(delta):
	#if Input.is_action_just_pressed("Shoot"):
		#Shoot()

#func Shoot():
	#const BULLET = preload("res://Scene/bullet.tscn")
	#var newBullet = BULLET.instantiate()
	#newBullet.position = %RayCast3D.global_position
	#newBullet.global_rotation = %RayCast3D.global_rotation
	#newBullet.transform.basis = %RayCast3D.global_transform.basis
	#get_parent().add_child(newBullet)
