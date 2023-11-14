extends Node2D

var x = [0.0]
var y = [0.0]
@export var R = [0.0]
var v = [0.0]
var w = [0.0]
var T = [0.0]
var t = 0
var phi = [0.0]
var MG = 393530000000000.0
var current_planet = 0
var is_active = false
var R0 = 0
var T0 = 0
var v0 = 0
var w0 = 0
var bodies = [$background/planet]
@export var planet: PackedScene
var current_sphere
var result_text = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$background/input/initial.select(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		var t_p = int(t/3600)
		t = t + delta*60*60
		var t_c = int(t/3600)
		if t_c-t_p>0:
			$background/input/timer/text.text = str(t_c)
		for i in range(len(bodies)):
			if i>0:
				phi[i] = w[i]*t
				x[i] = R[i]*cos(phi[i])
				y[i] = R[i]*sin(phi[i])
				bodies[i].position =  Vector2(x[i]/100000+700, y[i]/100000+300)
		
		


func _on_start_pressed():
	#Добавить начальные условия
	is_active = true
	

func _on_pause_pressed():
	is_active = not(is_active)
	if is_active:
		$background/input/pause.text = "Pause"
	else:
		$background/input/pause.text = "Resume"




	


func _on_add_pressed():
	var index = $background/input/initial.get_selected_items()[0]
	match index:
		0:
			T0 = float($background/input/i1/text.text)*3600
			R0 = pow(((MG*T0*T0)/(4*PI*PI)),(1.0/3.0))
			v0 = sqrt(MG/R0)
			
		1:
			R0 = float($background/input/i1/text.text)*1000
			v0 = sqrt(MG/R0)
			T0 = sqrt(4*PI*PI*(R0*R0*R0)/MG)
		
		2:
			v0 = float($background/input/i1/text.text)*1000
			R0 = MG/(v0*v0)
			T0 = sqrt(4*PI*PI*R0*R0*R0/MG)
			
	w0 = 2*PI/T0
	
	current_planet+=1
	v.append(v0)
	R.append(R0)
	T.append(T0)
	w.append(w0)
	phi.append(0.0)
	x.append(R0)
	y.append(0.0)
	current_sphere = planet.instantiate()


	bodies.append(current_sphere)
	current_sphere.position = Vector2(x[current_planet]/100000+700,y[current_planet]/10000+300)
	current_sphere.scale = Vector2(0.2, 0.2)
	print(current_sphere.position)
	$background.add_child(current_sphere)
	current_sphere.set_colour(current_planet)
	var result_template = "%d:\nR = %.f\nT = %.2f\nv = %.2f\n"
	var result_line = result_template % [current_planet, R0/1000, T0/3600, v0/1000]
	result_text+= result_line
	$background/input/results.text = result_text
	$background.redraw()
	


func _on_initial_item_selected(index):
	match index:
		0:
			$background/input/i1/label.text = "T"
			
		1:
			$background/input/i1/label.text = "R"
		
		2:
			$background/input/i1/label.text = "v"


		


func _on_clear_pressed():
	x.clear()
	x.append(0.0)
	y.clear()
	y.append(0.0)
	R.clear()
	R.append(0.0)
	v.clear()
	v.append(0.0)
	w.clear()
	w.append(0.0)
	T.clear()
	T.append(0.0)
	t = 0
	phi.clear()
	phi.append(0.0)
	current_planet = 0
	is_active = false
	R0 = 0
	T0 = 0
	v0 = 0
	w0 = 0
	$background/input/timer/text.text = "0"
	for i in range(len(bodies)):
		if i>0:
			bodies[1].queue_free()
			bodies.remove_at(1)
			$background/input/results.clear()
			result_text = ""
			$background.redraw()
