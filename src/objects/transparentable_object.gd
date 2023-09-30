class_name TransparentableObject extends StaticBody3D

@export var mesh_instances: Array[MeshInstance3D]

var materials: Array[StandardMaterial3D]

func _ready() -> void:
	materials = []
	for i in mesh_instances:
		materials.append(i.mesh.get("surface_0/material"))
#	for i in mesh_instance.mesh.get("surface_0/material").get_surface_override_material_count():
#		materials.append(mesh_instance.mesh.get("surface_0/material").get_surface_override_material(i))


func set_transparentcy(alpha: float) -> void:
	if alpha >= 1.0:
		for i in materials:
			var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(i, "albedo_color", Color(i.albedo_color, alpha), 0.4).from_current()
			await tween.finished
			i.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
			i.next_pass.set_shader_parameter("enabled", true)
	else:
		for i in materials:
			var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(i, "albedo_color", Color(i.albedo_color, alpha), 0.4).from_current()
			i.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_DEPTH_PRE_PASS
			i.next_pass.set_shader_parameter("enabled", false)




