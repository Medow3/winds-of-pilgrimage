class_name Player extends CharacterBody3D

@export var respawn_points_holder: Node

@onready var camera_rotation_pivot_point = $camera_rotation_pivot_point
@onready var rogue = $Rogue
@onready var animation_handler = $animation_handler

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 3.5
const DEATH_Y: float = -4.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_handler.travel_to("Jump_Full_Short")
		

	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	input_direction = input_direction.rotated(-camera_rotation_pivot_point.rotation.y)
	var direction: Vector3 = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	check_respawn()
	if velocity != Vector3.ZERO:
		if not animation_handler.current_animation == "Jump_Full_Short":
			animation_handler.travel_to("Walking_B")
		var move = velocity.normalized()
		rogue.rotation.y = atan2(move.x, move.z) + PI
	else:
		if not animation_handler.current_animation == "Jump_Full_Short":
			animation_handler.travel_to("Idle")


func check_respawn():
	if global_position.y < DEATH_Y:
		var closest_respawn_pos: Vector3 = Vector3(0, 2, 0)
		for i in respawn_points_holder.get_children():
			if global_position.distance_to(i.global_position) < global_position.distance_to(closest_respawn_pos):
				closest_respawn_pos = i.global_position
			Fade.fade_out_in(0.3)
			global_position = closest_respawn_pos
	
