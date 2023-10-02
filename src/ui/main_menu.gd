extends Control

@export var game: Node 

@onready var credits = $credits
@onready var main = $main
@onready var begin = $main/begin

func _ready() -> void:
	begin.grab_focus()
#	game.process_mode = Node.PROCESS_MODE_DISABLED


func _on_begin_pressed() -> void:
	print("pres")
	var tween = create_tween()
	visible = false
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	game.process_mode = Node.PROCESS_MODE_INHERIT


func _on_credits_pressed() -> void:
	print("pdd")
	
	credits.visible = true
	main.visible = false


func _on_back_pressed() -> void:
	credits.visible = false
	main.visible = true


func _on_button_pressed() -> void:
	print("ss")
