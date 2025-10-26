extends CharacterBody3D

var max_lanes: int
var curr_lane: int
@export var lives = 5
@export var max_velocity = 10


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		consume_movement(-1)
	if Input.is_action_just_pressed("right"):
		consume_movement(1)

func _physics_process(_delta: float) -> void:
	# simply teleporting for now as actually moving is too slow and blocks the input 
	position += velocity
	velocity.x = 0

func consume_movement(direction: int) -> void:
	var new_lane = curr_lane+sign(direction)
	if velocity.x == 0 and new_lane >= 0 and new_lane < max_lanes:
			velocity.x = sign(direction) * max_velocity
			curr_lane = new_lane
