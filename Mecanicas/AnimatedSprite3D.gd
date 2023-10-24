extends AnimatedSprite3D
var n

var anim = { 0 : "Aup", 1 : "Adown", 2 : "Aleft", 3 : "Aright",}

var sAnim = { 0 : "Sup", 1 : "Sdown", 2 : "Sleft", 3 : "Sright",}

func _ready():
	n = get_node("/root/Node3D/CharacterBody3D")

func _physics_process(delta):
	if(n.interpol):
		play(anim[n.valu])
	else:
		if(n.inp.is_empty() and ((Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left")))):
			play(anim[n.third])
		elif(get_frame() % 2 != 0):
			pause()
		
#LISTO!



