extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	set_button_icon (load("res://Tri32.png"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_focus():
		set_button_icon (load("res://Tri3.png"))
	else:
		set_button_icon (load("res://Tri32.png"))
	pass
