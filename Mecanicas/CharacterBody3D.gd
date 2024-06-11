extends CharacterBody3D

var iPosition = Vector3.ZERO
var fPosition = Vector3.ZERO
var inp = []
var taim : Array
var interpol = false
var grilla = 1
var valu = 1
var flag = 0
var third = 0
var mount = 0
var tempo4 = 0
var tempo5 = 0
var señalic = false
var dash1 = false
var sda = false
var cell
var lastcell

@onready var f = get_node("/root/Node3D/CharacterBody3D/CollisionShape3D")
@onready var g = get_node("/root/Node3D/CharacterBody3D/RayCast3D")
@onready var s = get_node("/root/Node3D/CharacterBody3D/RayCast3D2")
@onready var k = get_node("/root/Node3D/GridMap")


var mount_velocities = {0: 2, 1: 3.5, 2: 4,3: 4}
var mounting = { 1 : "fly", 2 : "mount", 3 : "swim"}
var keys ={ "ui_up" : 0, "ui_down" : 1, "ui_left" : 2, "ui_right" : 3}
var movi = { 0 : Vector3(0,0,-2), 1 : Vector3(0,0,2), 2 : Vector3(-2,0,0), 3 : Vector3(2,0,0),}

var jump_height = 1
var jump_time_to_peak = 0.25
var jump_time_to_descent = 0.2

var jump_velocity  = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_gravity  = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var jump_data = {
	0: {
		"jump_time_to_descent": 0.2,
		"jump_time_to_peak": 0.25,
		"jump_height": 1,
	},
	1: {
		"jump_time_to_descent": 0.5,
		"jump_time_to_peak": 0.25,
		"jump_height": 1,
	},
	2: {
		"jump_time_to_descent": 0.2,
		"jump_time_to_peak": 0.25,
		"jump_height": 1,
	},
	3: {
		"jump_time_to_descent": 0.3,
		"jump_time_to_peak": 0.3,
		"jump_height": 2,
	},
}

func recalc(delta):
	jump_time_to_descent = jump_data[mount]["jump_time_to_descent"]
	jump_time_to_peak = jump_data[mount]["jump_time_to_peak"]
	jump_height = jump_data[mount]["jump_height"]
	jump_velocity  = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity  = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
	if mount == 1:
		if Input.is_action_pressed("ui_accept") and tempo5 < 1:
			fall_gravity = 0
			velocity.y = 0
			tempo5 += delta
		else: 
			fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
	
func get_gravity():
	if velocity.y > 0.0:
		return -jump_gravity
	elif mount == 1:
		return -fall_gravity
	elif abs(get_floor_angle() - 0.4636) < 0.01:
		return 0
	else:
		return -fall_gravity

func jump():
	velocity.y = -jump_velocity
	
func dash():
	if !dash1:
		if not interpol:
			iPosition = transform.origin
		fPosition = movi[third]*2
		valu = third
		interpol = true
		dash1 = true

func floorcal():
	if is_on_floor():
		señalic = true
	if señalic == true:
		tempo5 = 0
		señalic = false
	

func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round_to_odd(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round_to_odd(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position

	
func round_to_odd(value):
	var rounded_value = round(value)
	if int(rounded_value) % 2 == 0:
		rounded_value += sign(value)
	return rounded_value
	
func _inputs():
	for dir in keys:
		taim[keys[dir]] = 0
		taim[third] = flag
	for dir in keys:
		if(Input.is_action_pressed(dir)):
			if not inp.has(keys[dir]):
				if(taim[keys[dir]] > 3 or not inp.is_empty()):
					inp.push_front(keys[dir])
				else:
					if(taim[keys[dir]] < 10):
						taim[keys[dir]] += 1
					if not interpol:
						flag = taim[keys[dir]]
						third = keys[dir]
			else:
				third = valu

func _sinputs():
	for dir in keys:
		if(Input.is_action_just_released(dir)):
			if(inp.has(keys[dir])):
				inp.remove_at(inp.find(keys[dir]))
				taim[keys[dir]] = 0

func montura():
	for m in mounting:
		if Input.is_action_just_pressed(mounting[m]):
			if(!mount):
				mount = m
			else:
				mount = 0
				
func movimiento():
	if !interpol and !dash1:
		if(not inp.is_empty()):
					iPosition = transform.origin
					fPosition = movi[inp.front()]
					valu = inp.front()
					interpol = true
	if interpol:
		var nvec= Vector2(transform.origin.x,transform.origin.z)
		var nvec2 = Vector2(iPosition.x+fPosition.x,iPosition.z+fPosition.z)
		var distancia = nvec.distance_to(nvec2)
		g.force_raycast_update()
		if (mount == 1 and distancia < 0.05) or distancia < 0.15 or g.is_colliding() or is_on_wall():
			if cell != 3:
				velocity.z = 0
				velocity.x = 0
			interpol = false
			dash1 = false
			snap_to_grid(1)
		else:
			velocity.x = fPosition.x * mount_velocities[mount]
			velocity.z = fPosition.z * mount_velocities[mount]

func apunte():
	if !inp.is_empty() and !interpol:
		g.target_position = movi[inp.front()]*0.55
	elif inp.is_empty():
		g.target_position = movi[third]*0.55
		
func accion():
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		if mount != 2:
			jump()
		else:
			dash()

func reaccion():
	var l = s.get_collision_point()
	var cell_index = l / k.cell_size
	cell_index = cell_index.floor()
	cell = k.get_cell_item(cell_index)
	if cell == -1:
		cell_index.y = cell_index.y -1
		cell = k.get_cell_item(cell_index)
	var ll = abs(abs(position.x)-abs(round(position.x))) < 0.01 and abs(abs(position.z)-abs(round(position.z))) < 0.01
	if cell != 3 and ll:
		velocity.x = 0
	lastcell = cell
	

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	taim = [0,0,0,0]
	position = Vector3(5,5,5)
	snap_to_grid(grilla)
	velocity.y = 0

func _process(delta):
	recalc(delta)
	velocity.y += get_gravity() * delta
	floorcal()
	if cell != 3 or velocity.x == 0:
		_inputs()
		montura()
	_sinputs()

func _physics_process(delta):
	reaccion()
	accion()
	movimiento()
	move_and_slide()
	apunte()
	



