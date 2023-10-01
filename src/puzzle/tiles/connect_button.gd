class_name ConnectButton extends PuzzleButton

var path: ArrayMesh;

var path_height = 0.05;

# Todo
func set_path(tiles: Dictionary, start: Vector3i, end: Vector3i, visited: Dictionary):
	
	var line_height = Vector3(0, path_height, 0)
	var start_pos = tiles[start].position
	var end_pos = tiles[end].position
	
	var vertices = PackedVector3Array()
	vertices.push_back(end_pos - start_pos)
	vertices.push_back(end_pos - start_pos + line_height)
	
	while true:
		end = visited[end]
		if end == start:
			break
		end_pos = tiles[end].position
		vertices.push_back(end_pos - start_pos + line_height + grid_map_offset)
		
	
	vertices.push_back(line_height)
	vertices.push_back(Vector3(0, 0, 0))
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_STRIP, arrays)
	
	path = arr_mesh

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
			set_path(tiles, start, pos, visited)
			return true
			
		if pos_tile.ignore_as_adjacent_tile:
			continue
		
		stack.push_back([pos + Vector3i(1,  0,  0), pos])
		stack.push_back([pos + Vector3i(-1, 0,  0), pos])
		stack.push_back([pos + Vector3i(0,  0,  1), pos])
		stack.push_back([pos + Vector3i(0,  0, -1), pos])
	
	return false

func on_puzzle_success():
	super.on_puzzle_success()
	$Line.visible = true
	$Line.mesh = path;
	
func on_puzzle_failure():
	super.on_puzzle_failure()
	$Line.visible = false
