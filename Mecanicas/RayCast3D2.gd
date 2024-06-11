extends RayCast3D
@onready var n = get_node("/root/Node3D/CharacterBody3D")
var tile_size = 1
var inputs ={
	0 : Vector3(0,0,-2),
	1 : Vector3(0,0,2),
	2 : Vector3(-2,0,0),
	3 : Vector3(2,0,0)
}

func _ready():
	position = n.position - Vector3(7,-5,1)

func _process(delta):
		rotation_degrees = Vector3(0,90,0)
		force_raycast_update()
		if is_colliding():
			n.interpol = false
			n.snap_to_grid(1)
			if(!n.inp.is_empty()):
				target_position = inputs[n.valu]
		if(n.interpol):
			target_position = inputs[n.valu]*0.5
		else:
			target_position = inputs[n.valu]*1
			if(n.inp.is_empty() and ((Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left")))):
				target_position = inputs[n.third]
			
func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position			
