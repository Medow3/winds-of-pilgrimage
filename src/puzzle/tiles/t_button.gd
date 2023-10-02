class_name TButton extends PuzzleButton

func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	var t_tile_pressed = tiles[start].is_pressed
	
	for pos in [
		start + Vector3i(-1, 0, 0), 
		start + Vector3i(1, 0, 0),
		start + Vector3i(0, 0, 1),
		start + Vector3i(0, 0, -1),
	]:
		if !tiles.has(pos):
			continue
		var adj_tile: PuzzleButton = tiles[pos]
		if adj_tile.ignore_as_adjacent_tile:
			continue
		if t_tile_pressed != adj_tile.is_pressed:
			evaluates_to_true = false
			return false
			
	evaluates_to_true = true
	return true


var evaluates_to_true: bool : set = _set_evaluates_to_true;

func _set_evaluates_to_true(b: bool):
	evaluates_to_true = b
	_set_texture()

@export var evaluating_material: StandardMaterial3D
@export var non_evaluating_material: StandardMaterial3D

func _set_texture():
	super._set_texture()
	if evaluates_to_true:
		set_surface_override_material(0, evaluating_material)
	else:
		set_surface_override_material(0, non_evaluating_material)
