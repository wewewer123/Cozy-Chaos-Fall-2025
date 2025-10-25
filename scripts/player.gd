extends CharacterBody3D
@export var max_velocity = 60
func _process(delta: float) -> void:
	if velocity.x == 0:
		if Input.is_action_just_pressed("left"):
			velocity.x = -max_velocity
		if Input.is_action_just_pressed("right"):
			velocity.x = max_velocity
func _physics_process(delta: float) -> void:
	if velocity.x != 0:
		velocity.x -= sign(velocity.x)
	
	move_and_slide()
		
