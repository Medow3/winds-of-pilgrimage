extends Node3D


@export var go_to_pos: Vector3
@export var puzzle: Puzzle


func _ready() -> void:
	puzzle.success.connect(open)


func open(puzzle: Puzzle):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", go_to_pos, 2).from_current()
