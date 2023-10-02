extends Control

@export var final_puzzle: Puzzle
@export var main: Node


func _ready() -> void:
	final_puzzle.success.connect(enable)


func enable(puzzle: Puzzle):
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5).set_delay(0.4)
	main.process_mode = Node.PROCESS_MODE_DISABLED


func _on_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 0.5)
	main.process_mode = Node.PROCESS_MODE_INHERIT
	
	
