class_name Player extends CharacterBody3D

@onready var camera_rotation_pivot_point = $camera_rotation_pivot_point

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	
