extends Sprite2D

@onready var root = get_parent()
@onready var R = root.R
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	for i in range(len(R)):
		draw_arc(Vector2(700, 300), R[i]/100000,0.0,2*PI,100,Color(0,0,0),1.0, true)

func redraw():
	queue_redraw()  # Trigger a redraw of the node.
