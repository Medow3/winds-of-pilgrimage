class_name ProgressButton extends PuzzleButton

var finished_once = false

func on_puzzle_success(puzzle):
	if !finished_once:
		Progress.puzzle_finished.emit(puzzle, self)
	finished_once = true

func draw_puzzle_complete_line(beacon_global_pos: Vector3):
	$Line.visible = true
	
	var vertices = PackedVector3Array()
	vertices.push_back(Vector3.ZERO)
	var beacon_pos;
	var parent = get_parent()
	if parent != null:
		beacon_pos = parent.to_local(beacon_global_pos)
	else:
		beacon_pos = beacon_global_pos
	vertices.push_back(beacon_pos - position)
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_STRIP, arrays)
	
	$Line.mesh = arr_mesh
