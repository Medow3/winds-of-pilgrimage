class_name PuzzleButton extends GameButton

@export var pressed_surface_texture: StandardMaterial3D = null
@export var released_surface_texture: StandardMaterial3D = null

@export var grid_map_offset: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var ignore_as_adjacent_tile = false

# Override this method
func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	return true

func on_puzzle_failure(puzzle: Puzzle):
	pass

func on_puzzle_success(puzzle: Puzzle):
	pass

func _set_texture():
	super._set_texture()
	var surface: MeshInstance3D = get_node("Surface")
	if surface == null:
		return
	if is_pressed:
		if pressed_surface_texture != null:
			surface.set_surface_override_material(0, pressed_surface_texture)
	elif released_surface_texture != null:
		surface.set_surface_override_material(0, released_surface_texture)
