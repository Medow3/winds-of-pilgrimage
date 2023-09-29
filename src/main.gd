extends Node2D

@export var test_sfx: SFXData

func _ready():
	SFX.play_sfx(test_sfx)
	await get_tree().create_timer(5).timeout
	SFX.play_sfx(test_sfx)
	await get_tree().create_timer(5).timeout
	Music.play_song("Radiative")
