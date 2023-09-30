class_name XButton extends PuzzleButton

func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	var x_tile_pressed = tiles[start].is_pressed
	
	for pos in [
		start + Vector3i(-1, 0, -1), 
		start + Vector3i(1, 0, -1),
		start + Vector3i(1, 0, 1),
		start + Vector3i(1, 0, -1),
	]:
		
		if !tiles.has(pos):
			continue
		if x_tile_pressed == tiles[pos].is_pressed:
			return false
			
	return true
