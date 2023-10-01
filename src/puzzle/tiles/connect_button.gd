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
		print(head)
		var last_pos = head[1]
		if !tiles.has(pos):
			continue
		print("aaa")
		if visited.has(pos):
			continue
		print("bbb")
		var pos_tile = tiles[pos];
		if !pos_tile.is_pressed:
			continue
		print("ccc")
		visited[pos] = last_pos;
		if pos_tile is ConnectButton:
			set_path(start, pos, visited)
			return true
			
		print("ddd")
			
		if pos_tile.ignore_as_adjacent_tile:
			continue
		
		print("eeessss")
		
		stack.push_back([pos + Vector3i(1,  0,  0), pos])
		stack.push_back([pos + Vector3i(-1, 0,  0), pos])
		stack.push_back([pos + Vector3i(0,  0,  1), pos])
		stack.push_back([pos + Vector3i(0,  0, -1), pos])
	
	return false

func on_puzzle_success():
	super.on_puzzle_success()
	
func on_puzzle_failure():
	super.on_puzzle_failure()
