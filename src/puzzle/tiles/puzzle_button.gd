class_name PuzzleButton extends GameButton


var grid_map_offset: Vector3 = Vector3(0.0, 0.0, 0.0)
var ignore_as_adjacent_tile = false

# Override this method
func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	return true

func on_puzzle_failure():
	pass

func on_puzzle_success():
	pass
