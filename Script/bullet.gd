extends Area3D

var travelled_distance = 0.0
var range = 1200.0
var damage = 25.0
const SPEED = 1000.0

@onready var mesh = $Bullet
@onready var ray = $RayCast3D

func _physics_process(delta):
	position += transform.basis * Vector3(0,0, -SPEED) * delta
	travelled_distance += SPEED * delta
	if travelled_distance > range:
		queue_free()
		



func _on_body_entered(body):
	queue_free()
	if body.has_method("TakeDamage"):
		body.TakeDamage(damage)
