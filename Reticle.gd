extends CenterContainer

@export var dot_radius : float = 1.0
@export var dot_color : Color = Color.WHITE
# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_circle(Vector2(0,0),dot_radius,dot_color)
