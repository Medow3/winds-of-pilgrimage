class_name PlayerCamera extends Camera3D

@export var rotation_speed: float = 1.5
@export var crouch_rotation_speed_modifier: float = 0.25
@export var crouch_rotation_speed_modifier_tween_duration: float = 0.4

@export var rotation_snap_degrees: float = 45.0
#@export var rotation_offset: float = 45.0
@export var rotation_snap_tween_duration: float = 0.75
@export var min_rotation_snap_distance: float = 10.0

@onready var camera_rotation_pivot = $".."
@onready var rotation_tween: Tween = create_tween()
@onready var rotation_speed_modifier_tween: Tween = create_tween()

const TRANSPARENT_ALPHA: float = 0.2

var last_rotation_direction: float = 1.0
var current_rotation_speed_modifier: float = 1.0
var current_raycast_hit_object: Node = self

#func _ready():
#	rotation_degrees.y = rotation_offset


func _physics_process(delta: float):
	_update_rotation_speed_modifier()
	_handle_camera_rotation(delta)
	
	var space_state = get_world_3d().direct_space_state
	var ray_start_pos = global_position
	var ray_to_pos = get_viewport().size / 2.0
	var ray_length = ray_start_pos.distance_to(get_parent().global_position)

	var origin = project_ray_origin(ray_to_pos)
	var end = origin + project_ray_normal(ray_to_pos) * ray_length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	if result != {}:
		if result["collider"] is TransparentableObject:
			result["collider"].set_transparentcy(TRANSPARENT_ALPHA)
		if result["collider"] != current_raycast_hit_object:
			if current_raycast_hit_object is TransparentableObject:
				current_raycast_hit_object.set_transparentcy(1.0)
		current_raycast_hit_object = result["collider"]
	


func _handle_camera_rotation(delta: float) -> void:
	var rotation_strength: float = (
		Input.get_action_strength("Rotate Camera Counterclockwise") - 
		Input.get_action_strength("Rotate Camera Clockwise")
	)
	var rotation_direction: float = sign(rotation_strength)
	var rotation_pivot: Vector3 = camera_rotation_pivot.rotation_degrees
	
	if (not abs(rotation_pivot.y - snappedf(rotation_pivot.y, rotation_snap_degrees)) < 0.001 
			and abs(rotation_strength) < 0.001):
		if not rotation_tween.is_valid():
			_tween_to_snap_rotation()
	elif rotation_strength != 0.0:
		if rotation_tween.is_valid():
			rotation_tween.kill()
		camera_rotation_pivot.rotate_y(rotation_strength * rotation_speed * current_rotation_speed_modifier * delta)
		last_rotation_direction = rotation_direction


func _tween_to_snap_rotation() -> void:
	var rotation_pivot: Vector3 = camera_rotation_pivot.rotation_degrees
	rotation_tween = create_tween()
	var final_rotation_value: float = snappedf(rotation_pivot.y + (sign(last_rotation_direction) * (rotation_snap_degrees / 2.0)), rotation_snap_degrees)
	var rotation_distance: float = abs(rotation_pivot.y - final_rotation_value)
	if rotation_distance < min_rotation_snap_distance:
		var added_rotation = sign(last_rotation_direction) * rotation_snap_degrees
		final_rotation_value += added_rotation
		rotation_distance += rotation_snap_degrees
	var vec_final_rotation: Vector3 = rotation_pivot
	vec_final_rotation.y = final_rotation_value
	
	rotation_tween.tween_property(
		camera_rotation_pivot,
		"rotation_degrees", 
		vec_final_rotation,
		rotation_snap_tween_duration
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _update_rotation_speed_modifier() -> void:
	if Input.is_action_just_pressed("Crouch"):
		_tween_rotation_speed_modifier_to(crouch_rotation_speed_modifier)
		
	if Input.is_action_just_released("Crouch"):
		_tween_rotation_speed_modifier_to(1.0)


func _tween_rotation_speed_modifier_to(final_value: float) -> void:
	if rotation_speed_modifier_tween.is_valid():
		rotation_speed_modifier_tween.kill()
	rotation_speed_modifier_tween = create_tween()
	rotation_speed_modifier_tween.tween_property(
		self,
		"current_rotation_speed_modifier",
		final_value,
		crouch_rotation_speed_modifier_tween_duration
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)




