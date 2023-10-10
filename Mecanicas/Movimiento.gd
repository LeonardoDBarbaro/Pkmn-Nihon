extends CharacterBody3D

var is_interpolating = false
@onready var anim = $AnimatedSprite3D
var target_position = Vector3()
var dirau = 0

func _process(delta):
	if not is_interpolating:
		if Input.is_action_pressed("ui_down"):
			anim.play("adelante")
			target_position = transform.origin + Vector3(0, 0, 2)
			is_interpolating = true
			dirau = 1
		elif Input.is_action_pressed("ui_up"):
			anim.play("atras")
			target_position = transform.origin + Vector3(0, 0, -2)
			is_interpolating = true
			dirau = 2
		elif Input.is_action_pressed("ui_left"):
			anim.play("izquierda")
			target_position = transform.origin + Vector3(-2, 0, 0)
			is_interpolating = true
			dirau = 3
		elif Input.is_action_pressed("ui_right"):
			anim.play("derecha")
			target_position = transform.origin + Vector3(2, 0, 0)
			is_interpolating = true
			dirau = 4
		else:
				if(dirau==0 or dirau==1): anim.play("Idown")
				elif(dirau==2): anim.play("Iup")
				elif(dirau==3): anim.play("Ileft")
				elif(dirau==4): anim.play("Iright")

	if is_interpolating:
		var lerp_amount = 0.35  # Ajusta esta cantidad según lo necesites (0.0 a 1.0)
		transform.origin = transform.origin.lerp(target_position, lerp_amount)

		# Comprueba si la interpolación ha terminado
		if transform.origin.distance_to(target_position) < 0.01:
			is_interpolating = false
