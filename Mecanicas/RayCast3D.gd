extends RayCast3D
@onready var n = get_node("/root/Node3D/CharacterBody3D")
var tile_size = 64
var inputs ={
	0 : Vector3(0,0,-2),
	1 : Vector3(0,0,2),
	2 : Vector3(-2,0,0),
	3 : Vector3(2,0,0)
}

func _ready():
	position = position.snapped(Vector3.ONE * 2)
	position += Vector3.ONE * 2/2

func _physics_process(delta):
		target_position = inputs[n.third]
		force_raycast_update()
		if !is_colliding():
			position = inputs[n.third]
