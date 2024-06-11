extends Control

@onready var f = get_node("/root/Node3D/CharacterBody3D")
@onready var g = get_node("/root/Node3D/Control")
@onready var bu
var last = 1
var taim = 0
var m

func _on_pause_button_pressed():
	get_tree().paused = true
	show()
	bu.grab_focus()
	

	
func _on_close_button_pressed():
	get_tree().paused = false
	hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	bu = get_node("/root/Node3D/pause_popup/VBoxContainer/Button")
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	taim -= delta
	if Input.is_action_pressed("pausa"):
		if taim <= 0 and not f.interpol: 
			if last == 1:
				_on_pause_button_pressed()
				last = 0
			elif last == 0:
				_on_close_button_pressed()
				last = 1
			taim = 0.5
