extends StaticBody3D

@export var is_pressed = true

signal pressed();

signal released();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	
func _on_area_3d_body_entered(body):
	is_pressed = !is_pressed
	if is_pressed:
		emit_signal("pressed")
	else:
		emit_signal("released")

func _on_area_3d_body_exited(body):
	pass
