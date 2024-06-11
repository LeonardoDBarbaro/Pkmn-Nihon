extends AnimatedSprite3D
var n
var f
var direc

var anim = { 0 : "Aup", 1 : "Adown", 2 : "Aleft", 3 : "Aright",}
var fanim = { 0 : "Fup", 1 : "Fdown", 2 : "Fleft", 3 : "Fright",}
var sanim = { 0 : "Sup", 1 : "Sdown", 2 : "Sleft", 3 : "Sright",}
var manim = { 0 : "Mup", 1 : "Mdown", 2 : "Mleft", 3 : "Mright",}
var mounting = {0 : "anim", 1 : "fanim", 2 : "sanim", 3 : "manim"}
var jrel = ["fly","swim","mount","ui_up","ui_down","ui_left","ui_right"]


func _ready():
	
	n = get_node("/root/Node3D/CharacterBody3D")
	f = get_node("/root/Node3D/CharacterBody3D/Node3D/RayCast3D6")
	direc = 0

func _physics_process(_delta):
	if !n.inp.is_empty() or n.interpol:
		for i in mounting:
			if(n.mount == i):
				play(get(mounting[i])[n.valu])
	else:
		for i in jrel:
			if Input.is_action_just_released(i):
				for j in mounting:
					if(n.mount == j):
						play(get(mounting[j])[n.third])
			elif(get_frame() % 2 != 0):
				pause()
