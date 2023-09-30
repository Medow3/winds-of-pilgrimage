class_name PuzzleButton extends GameButton

# Override this method
func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	return true

func on_puzzle_failure():
	pass

func on_puzzle_success():
	pass
