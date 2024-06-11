extends Node3D
#@onready var n = get_node("/root/Node3D/CharacterBody3D")
#@onready var m = get_node("/root/Node3D/CharacterBody3D/AnimatedSprite3D")
#@onready var f = get_node("/root/Node3D/CharacterBody3D/Node3D/RayCast3D6")
#@onready var limon = get_node("/root/Node3D/CharacterBody3D/Node3D/RayCast3D")
#@onready var e = get_node("/root/Node3D/CharacterBody3D/Node3D/ShapeCast3D2")
#@onready var g = get_node("/root/Node3D/CharacterBody3D/Node3D/ShapeCast3D")
#@onready var lel = get_node("/root/Node3D/CharacterBody3D/AnimatedSprite3D")
#
#var to = Vector3.ZERO
#var lista : Array
#signal interaccion
#var flagi = false
#var sum = Vector3.ZERO
#var sumant = Vector3.ZERO
#var new_position
#var count = 0
#var aire = false
#var savi = 0
#var maxim = 0
#var ant = Vector3.ZERO
#var subin = false
#
#var movi = { 0 : Vector3(0,0,-2), 1 : Vector3(0,0,2), 2 : Vector3(-2,0,0), 3 : Vector3(2,0,0),}
#var keys ={ "ui_up" : 0, "ui_down" : 1, "ui_left" : 2, "ui_right" : 3}
#
#func _ready():
	#g.add_exception(n)
	#e.add_exception(n)
	#limon.add_exception(n)
	#g.target_position = Vector3(0, 0, 0)
	#e.target_position = Vector3(0,0,0)
	
#func _physics_process(delta):
#
	#g.rotation = Vector3(limon.get_collision_normal().z,0,-limon.get_collision_normal().x)
	#if(!n.inp.is_empty()):
		#f.position = movi[n.inp.front()]/1.9 + Vector3(0,1,0)
		#f.target_position = -Vector3(0,2,0)
	#else:
		#f.position = movi[n.third]/1.9 + Vector3(0,1,0)
		#f.target_position = -Vector3(0,2,0)
	#if g.get_collision_count() == 0:
		#lista.push_front(Vector3.ZERO)
	#for i in range(g.get_collision_count()):
		#sum += g.get_collision_normal(i)
	#var dedo = limon.get_collision_point().y + 0.25 + n.consal*delta
	#ant = g.get_collision_normal(0)
	#g.force_shapecast_update()
	##n.velocity.y = -n.consal
	##n.up_direction = Vector3(0,1,0)
	##if n.is_on_floor():
		##print("ola")
	##if g.get_collision_normal(0).y == 0:
		##n.position.y -= n.consal*delta
		##aire = true
	##if n.position.y <= dedo:
		##new_position = limon.get_collision_point().y+0.25
		##var diff = abs(new_position) - abs(n.position.y)
		##if new_position != n.position.y:
			##n.position.y = new_position
			##aire = false
	##if aire and g.is_colliding() and n.position.y < f.get_collision_point().y:
		##n.interpol = false
		##n.snap_to_grid(1)
	##if abs(g.get_collision_normal(0).x) == 1 or abs(g.get_collision_normal(0).z) == 1:
		##n.interpol = false
		##n.snap_to_grid(1)
	#lista.clear()
	#sum = Vector3.ZERO
		

