extends Node3D

@export var progress_mask: int = -2
@export var puzzle_threshold: int = 1

var unique_puzzles = {}

var puzzle_threshold_met_flag = false

signal puzzle_threshold_met;

# Called when the node enters the scene tree for the first time.
func _ready():
	Progress.puzzle_finished.connect(on_puzzle_finished)
	
func on_puzzle_finished(puzzle: Puzzle, progress_button: ProgressButton):
	progress_button.draw_puzzle_complete_line($Sphere.global_position)
	
	unique_puzzles[puzzle] = true
	if puzzle_threshold_met_flag:
		return
	
	if unique_puzzles.size() >= puzzle_threshold:
		puzzle_threshold_met.emit()
		puzzle_threshold_met_flag = true
		
