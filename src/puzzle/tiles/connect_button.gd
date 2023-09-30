class_name ConnectButton extends PuzzleButton

var path;

# Todo
func set_path(start: Vector3i, end: Vector3i, visited: Dictionary):
	pass

func evaluate_in_puzzle(tiles: Dictionary, start: Vector3i):
	var visited = { start: true }
	var stack = [
		[start + Vector3i(1, 0, 0), start],
		[start + Vector3i(-1, 0, 0), start],
		[start + Vector3i(0, 0, 1), start],
		[start + Vector3i(0, 0, -1), start]
	]
	
	while !stack.is_empty():
		var head = stack.pop_front();
		var pos = head[0]
		var last_pos = head[1]
		if !tiles.has(pos):
			continue
		if visited.has(pos):
			continue
		
		var pos_tile = tiles[pos];
		if !pos_tile.is_pressed:
			continue
		
		visited[pos] = last_pos;
		if pos_tile is ConnectButton:
			set_path(start, pos, visited)
			return true
		stack.push_back([pos + Vector3i(1,  0,  0), pos])
		stack.push_back([pos + Vector3i(-1, 0,  0), pos])
		stack.push_back([pos + Vector3i(0,  0,  1), pos])
		stack.push_back([pos + Vector3i(0,  0, -1), pos])
	
	return false

func on_puzzle_success():
	super.on_puzzle_success()
	
func on_puzzle_failure():
	super.on_puzzle_failure()
