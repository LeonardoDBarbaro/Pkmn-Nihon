extends CharacterBody3D

var is_interpolating = false
@onready var anim = $AnimatedSprite3D
var target_position = Vector3()
var dirau = 0
var move_speed = 7.2  # Puedes ajustar esta velocidad según tus necesidades
var grid_spacing = 1
var tempo = 0
var tempo2 = 0

func _process(delta):
	if not is_interpolating:
		tempo -= delta
		tempo2 -= delta
		if(tempo<0):
			tempo = 0
		if Input.is_action_pressed("ui_down"):
			if(dirau != 1 and tempo2 <= 0):
				anim.play("Idown")
				dirau = 1
				tempo = 0.13
			else:
				if(tempo <= 0):
					anim.play("adelante")
					target_position = transform.origin + Vector3(0, 0, 2)
					is_interpolating = true
					dirau = 1
		elif Input.is_action_pressed("ui_up"):
			if(dirau != 2 and tempo2 <= 0):
				anim.play("Iup")
				dirau = 2
				tempo = 0.13
			else:
				if(tempo <= 0):
					anim.play("atras")
					target_position = transform.origin + Vector3(0, 0, -2)
					is_interpolating = true
					dirau = 2
		elif Input.is_action_pressed("ui_left"):
			if(dirau != 3 and tempo2 <= 0):
				anim.play("Ileft")
				dirau = 3
				tempo = 0.13
			else:
				if(tempo <= 0):
					anim.play("izquierda")
					target_position = transform.origin + Vector3(-2, 0, 0)
					is_interpolating = true
					dirau = 3
		elif Input.is_action_pressed("ui_right"):
			if(dirau != 4 and tempo2 <= 0):
				anim.play("Iright")
				dirau = 4
				tempo = 0.13
			else:
				if(tempo <= 0):
					anim.play("derecha")
					target_position = transform.origin + Vector3(2, 0, 0)
					is_interpolating = true
					dirau = 4
		else:
			if dirau == 0 or dirau == 1:
				anim.play("Idown")
			elif dirau == 2:
				anim.play("Iup")
			elif dirau == 3:
				anim.play("Ileft")
			elif dirau == 4:
				anim.play("Iright")

	if is_interpolating:
		var distance = transform.origin.distance_to(target_position)
		if distance > 0.1:
			var lerp_amount = move_speed * delta / distance
			transform.origin = transform.origin.lerp(target_position, lerp_amount)
		else:
			is_interpolating = false
			tempo2 = 0.5
			snap_to_grid(grid_spacing)

func snap_to_grid(grid_spacing):
	var rounded_position = Vector3(
		round(transform.origin.x / grid_spacing) * grid_spacing,
		transform.origin.y,
		round(transform.origin.z / grid_spacing) * grid_spacing
	)
	transform.origin = rounded_position
