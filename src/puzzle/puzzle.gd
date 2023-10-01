class_name Puzzle extends GridMap

var tiles: Dictionary = {} 

signal success
signal failure

var TILES = [
	load("res://src/puzzle/tiles/puzzle_button.tscn"),
	load("res://src/puzzle/tiles/on_button.tscn"),
	load("res://src/puzzle/tiles/off_button.tscn"),
	load("res://src/puzzle/tiles/connect_button.tscn"),
	load("res://src/puzzle/tiles/t_button.tscn"),
	load("res://src/puzzle/tiles/x_button.tscn"),
	load("res://src/puzzle/tiles/r_button.tscn"),
	load("res://src/puzzle/tiles/v_button.tscn"),
	load("res://src/puzzle/tiles/wall_button.tscn"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells():
		var world_cell = map_to_local(cell)
		var item = get_cell_item(cell)
		var button: PuzzleButton = TILES[item].instantiate()
		add_child(button)
		button.position = world_cell
		if "grid_map_offset" in button:
			button.position += button.grid_map_offset
		button.pressed.connect(self.on_tile_update)
		button.released.connect(self.on_tile_update)
		success.connect(button.on_puzzle_success)
		failure.connect(button.on_puzzle_failure)
		tiles[cell] = button
		set_cell_item(cell, INVALID_CELL_ITEM)

func on_tile_update():
	for cell in tiles.keys():
		var tile: PuzzleButton = tiles[cell]
		if !tile.evaluate_in_puzzle(tiles, cell):
			emit_signal("failure")
			return;
	emit_signal("success")

