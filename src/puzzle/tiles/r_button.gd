class_name RButton extends PuzzleButton

func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	var count = 0;
	
	for pos in [
		start + Vector3i(-1, 0, -1),
		start + Vector3i(0, 0, -1),
		start + Vector3i(1, 0, -1),
		start + Vector3i(-1, 0, 0),
		start,
		start + Vector3i(1, 0, 0),
		start + Vector3i(-1, 0, 1),
		start + Vector3i(0, 0, 1),
		start + Vector3i(1, 0, 1),
	]:
		if !tiles.has(pos):
			continue
		var adj_tile: PuzzleButton = tiles[pos]
		if adj_tile.ignore_as_adjacent_tile:
			continue
		if adj_tile.is_pressed:
			count += 1;
	
	return count == 4;
