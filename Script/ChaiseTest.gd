extends RigidBody3D

const ID = 1
var push_force = 80.0


func GetID():
	Global.ID = ID
	
func MoveWhenBodyEntered():
	var collidingBodies = get_colliding_bodies()
	for i in collidingBodies:
		if (collidingBodies[i] >= 1):
			apply_force(Vector3(10,0,0))
			

