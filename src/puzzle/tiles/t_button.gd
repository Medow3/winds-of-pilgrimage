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
			return false
			
	return true
