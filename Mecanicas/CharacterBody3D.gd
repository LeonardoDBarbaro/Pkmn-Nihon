extends CharacterBody3D

var ant = 0
var tempo = 0
var iPosition = Vector3.ZERO
var fPosition = Vector3.ZERO
var inp = []
var taim : Array
var interpol = false
var distancia = 0.0
var speed = 3.2
var grilla = 2
var valu = 1
var act = Vector3.ZERO
var flag = 0
var third = 0
var anter = Vector3.ZERO
var timer = 0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var anim = $AnimatedSprite3D

var anima = {
	0 : "Aup",
	1 : "Adown",
	2 : "Aleft",
	3 : "Aright",
}

var sanima = {
	0 : "Sup",
	1 : "Sdown",
	2 : "Sleft",
	3 : "Sright",
}

var keys ={
	"ui_up" : 0,
	"ui_down" : 1,
	"ui_left" : 2,
	"ui_right" : 3
}

var movi = {
	0 : Vector3(0,0,-2),
	1 : Vector3(0,0,2),
	2 : Vector3(-2,0,0),
	3 : Vector3(2,0,0),
}

# FUNCIONES
func getinp():
	return inp

func gettaim():
	return taim

func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position

func _inputs(delta):
	for dir in keys:
		taim[keys[dir]] = 0
		taim[third] = flag
	for dir in keys:
		if(Input.is_action_pressed(dir)):
			if(not inp.has(keys[dir]) and taim[keys[dir]] > 4):
				inp.push_front(keys[dir])
			if(!inp.is_empty() and not inp.has(keys[dir])):
				inp.push_front(keys[dir])
			else:
				if(taim[keys[dir]] < 10):
					taim[keys[dir]] += 1
					flag = taim[keys[dir]]
					third = keys[dir]
					print(third)

func _sinputs():
	for dir in keys:
		if(Input.is_action_just_released(dir)):
			if(inp.has(keys[dir])):
				inp.remove_at(inp.find(keys[dir]))
				taim[keys[dir]] = 0
# FIN FUNCIONES
func _ready():
	taim = [0,0,0,0]
	anter = Vector3.ZERO

func _process(delta):
	_inputs(delta)
	if not interpol:
		if(not inp.is_empty()):
				iPosition = transform.origin
				fPosition = movi[inp.front()]
				valu = inp.front()
				interpol = true
	if interpol:
		distancia = transform.origin.distance_to(iPosition+fPosition)
		if(distancia < 0.1):
			interpol = false
			#snap_to_grid(grilla)
		else:
			transform.origin = transform.origin + fPosition*delta*speed
	_sinputs()

