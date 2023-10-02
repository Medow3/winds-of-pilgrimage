extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body is Puzzle:
		print("paly")
		Music.play_ruins()


func _on_body_exited(body: Node3D) -> void:
	if body is Puzzle:
		print("paldddy")		
		Music.stop_ruins()
