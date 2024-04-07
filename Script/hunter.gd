extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var push_force = 5
var health = 100.0

@onready var neck = $neck
@onready var cam = $neck/CameraFPS
@onready var gun_barrel = $neck/CameraFPS/ProtoGun/RayCast3D
@onready var labelCurrentHealth = $UserInterface/BoxContainer/CurrentHealth

func _enter_tree():
	set_multiplayer_authority(name.to_int())


func _ready():
	cam.current = is_multiplayer_authority()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _unhandled_input(event):
	if is_multiplayer_authority():
		if event is InputEventMouseButton:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#%OptionMenu.show()
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				neck.rotate_y(-event.relative.x * 0.01)
				cam.rotate_x(-event.relative.y * 0.01)
				cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	if is_multiplayer_authority():
		cam.current = is_multiplayer_authority()
		move(delta)
		labelCurrentHealth.text = str(health)
		if Input.is_action_just_pressed("Shoot"):
			Shoot()


func move(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
func Shoot():
	const BULLET = preload("res://Scene/bullet.tscn")
	var newBullet = BULLET.instantiate()
	newBullet.position = gun_barrel.global_position
	#newBullet.global_rotation = gun_barrel.global_rotation
	newBullet.transform.basis = gun_barrel.global_transform.basis
	get_parent().add_child(newBullet)
	

