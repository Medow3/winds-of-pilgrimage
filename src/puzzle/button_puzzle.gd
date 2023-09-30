class_name ButtonPuzzle extends GridMap

var tiles: Dictionary = {} 

var TILES = [
	load("res://src/puzzle/tiles/puzzle_button.tscn"),
	load("res://src/puzzle/tiles/on_button.tscn"),
	load("res://src/puzzle/tiles/off_button.tscn"),
	load("res://src/puzzle/tiles/connect_button.tscn"),
	load("res://src/puzzle/tiles/t_button.tscn"),
	load("res://src/puzzle/tiles/x_button.tscn"),
	load("res://src/puzzle/tiles/r_button.tscn"),
	load("res://src/puzzle/tiles/v_button.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells():
		var world_cell = map_to_local(cell)
		var item = get_cell_item(cell)
		print(item)
		var button: PuzzleButton = TILES[item].instantiate()
		button.position = world_cell
		add_child(button)
		tiles[cell] = button
		set_cell_item(cell, INVALID_CELL_ITEM)

func on_tile_update():
	pass
