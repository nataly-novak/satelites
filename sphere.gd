extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_colour(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_colour(n):
	$ball.modulate = Color.from_hsv(n/12.0, 1, 1)
