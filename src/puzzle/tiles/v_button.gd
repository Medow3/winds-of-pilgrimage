extends PuzzleButton


func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	var v_tile_pressed = tiles[start].is_pressed
	
	var count = 0;
	
	for pos in [
		start + Vector3i(-1, 0, -1),
		start + Vector3i(0, 0, -1),
		start + Vector3i(1, 0, -1),
		start + Vector3i(-1, 0, 0),
		start + Vector3i(1, 0, 0),
		start + Vector3i(-1, 0, 1),
		start + Vector3i(0, 0, 1),
		start + Vector3i(1, 0, 1),
	]:
		if !tiles.has(pos):
			continue
		if tiles[pos].is_pressed:
			count += 1;
	
	return (count % 2 == 1) == v_tile_pressed 