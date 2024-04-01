extends Area3D

var travelled_distance = 0
const SPEED = 1000.0

@onready var mesh = $Bullet
@onready var ray = $RayCast3D

func _physics_process(delta):
	position += transform.basis * Vector3(0,0, -SPEED) * delta
