extends CharacterBody3D

var is_interpolating = false
var target_position = Vector3()
var dirau = -1
var move_speed = 7.2  # Puedes ajustar esta velocidad según tus necesidades
var grid_spacing = 1
var tempo = 0
var tempo2 = 0
var flag = 0
@export var a = Vector2.ZERO
var b : Vector2
var c : Vector2
var d : Vector2
var k : Vector2
var flag2 = 0
var flag3 = 0
var simul = Vector4.ZERO
var cambio = Vector4.ZERO
var moving = false

func geta():
	return k

func getsimul():
	return simul

func _process(delta):
	if not is_interpolating:
		tempo -= delta
		tempo2 -= delta
		tempo = max(tempo,0)
		tempo2 = max(tempo2,0)
		a = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized().round()
		if(Input.is_action_pressed("ui_up")):
			simul[0] = 1
		if(Input.is_action_pressed("ui_down")):
			simul[1] = 1
		if(Input.is_action_pressed("ui_left")):
			simul[2] = 1
		if(Input.is_action_pressed("ui_right")):
			simul[3] = 1
		if((Input.get_vector("b","ui_left","a","ui_right").normalized().round() == Vector2(1,1) or Input.get_vector("b","ui_up","a","ui_down").normalized().round() == Vector2(1,1)) and simul.length_squared()<3):
			if(flag2 == 0 and flag3 == 0):
				a = -c
				b = a
				flag2 = 1
				flag3 = 1
			else:
				a = b
		if((a != Vector2.ZERO) and tempo == 0):
			if(flag3 == 0 or flag2 == 0):
				if(flag == 1):
					if(abs(d) != abs(a)):
						flag = 0
					else:
						if(c.x == 0 or c.y == 0):
							a = c
				elif(flag == 0 and (a.length_squared() == 2) and (c.length_squared() == 1)):
					d = a
					if(c.x == 0):
						a.y = 0
					else:
						a.x = 0
					flag = 1
			print(dirau)
			moving == true
			if(a == Vector2(0,1)):
					if(dirau == 0):
						position = transform.origin + Vector3(0, 0, 2)
					else:
						dirau = 0
						print("SI SOY YO")
			elif(a == Vector2(0,-1)):
					if(dirau == 1):
						position = transform.origin + Vector3(0, 0, -2)
						moving = true
					else:
						dirau = 1
			elif(a == Vector2(1,0)):
					if(dirau == 2):
						position = transform.origin + Vector3(2, 0, 0)
						moving = true
					else:
						dirau = 2
			elif(a == Vector2(-1,0)):
					if(dirau == 3):
						position = transform.origin + Vector3(-2, 0, 0)
						moving = true
					else:
						dirau = 3
			c = a
			k = a
			tempo = 0.05
		if(Input.is_action_just_released("ui_up")):
			simul[0] = 0
			flag2 = 0
		if(Input.is_action_just_released("ui_down")):
			simul[1] = 0
			flag2 = 0
		if(Input.is_action_just_released("ui_left")):
			simul[2] = 0
			flag3 = 0
		if(Input.is_action_just_released("ui_right")):
			simul[3] = 0
			flag3 = 0	
	if(simul.length_squared() == 0):
		k = Vector2.ZERO
#		else:
#			if dirau == 0 or dirau == 1:
#				anim.play("Idown")
#			elif dirau == 2:
#				anim.play("Iup")
#			elif dirau == 3:
#				anim.play("Ileft")
#			elif dirau == 4:
#				anim.play("Iright")

	if is_interpolating:
		var distance = transform.origin.distance_to(target_position)
		if distance > 0.3:
			var lerp_amount = move_speed * delta / distance
			transform.origin = transform.origin.lerp(target_position, lerp_amount)
		else:
			if(flag == 1):
				snap_to_grid(grid_spacing)
				target_position = transform.origin + Vector3(0, 0, 2)
				flag = 2
				print("si aca estoy")
			else:
				is_interpolating = false
				tempo2 = 0.2
				snap_to_grid(grid_spacing)
				flag = 0

func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position
