class_name GameButton extends MeshInstance3D

@export var is_pressed = false : set = _set_is_pressed
@export var is_disabled = false : set = _set_is_disabled
@export var disable_on_toggle = false

@export var pressed_texture: StandardMaterial3D = null;
@export var released_texture: StandardMaterial3D = null;
@export var disabled_texture: StandardMaterial3D = null;

signal pressed();
signal released();
signal disabled();

func _set_is_pressed(val: bool):
	is_pressed = val
	_set_texture()

func _set_is_disabled(val: bool):
	is_disabled = val
	_set_texture()

func _set_texture():

	if is_disabled and disabled_texture != null:
		set_surface_override_material(0, disabled_texture)
	elif is_pressed:
		if pressed_texture != null:
			set_surface_override_material(0, pressed_texture)
	elif released_texture != null:
		set_surface_override_material(0, released_texture)

func _ready():
	is_pressed = is_pressed

func _on_trigger_body_entered(body):
	if body is Player:
		if is_disabled:
			return
		
		is_pressed = !is_pressed
		if is_pressed:
			pressed.emit()
		else:
			released.emit()

		if disable_on_toggle:
			is_disabled = true
		

func _on_trigger_body_exited(body):
	pass # Replace with function body.



