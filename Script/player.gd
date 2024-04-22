extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var push_force = 5

@onready var neck = %neck
@onready var cam = %CameraFPS
@onready var raycast = %RayCast3D
@onready var labelCurrentHealth = $UserInterface/BoxContainer/CurrentHealth


@export var sens = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.0025)
			cam.rotate_x(-event.relative.y * 0.0025)
			neck.rotation.x = clamp(cam.rotation.x, deg_to_rad(-30), deg_to_rad(60))
			


func _physics_process(delta):
	move(delta)


func move(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta

	# Handle the fact to go up.
	if Input.is_action_pressed("sauter"):
		velocity.y = JUMP_VELOCITY
	elif !Input.is_action_pressed("sauter"):
		velocity.y = 0.0
		
	if Input.is_action_pressed("accroupi"):
		velocity.y = -JUMP_VELOCITY
	elif !Input.is_action_pressed("sauter"):
		velocity.y = 0.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Gauche", "Droite", "Avancer", "Reculer")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# after calling move_and_slide()
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody3D:
			#c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func ChangePlayer():
	Global.ChangeThePlayer(global_position)
	queue_free()
	
