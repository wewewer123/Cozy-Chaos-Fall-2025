extends CharacterBody3D

var max_lanes: int
var curr_lane: int
var curr_health : int

@export var leaf = 0
@export var max_velocity = 10

signal lives_changed(curr_health: int)
signal player_died()

func _ready() -> void:
	curr_health = Globals.max_player_health

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

func incrementLive() -> void:
	_changeLives(1)
	
func decrementLive() -> void:
	_changeLives(-1)

func _changeLives(value: int) -> void:
	curr_health += value
	
	if(curr_health > Globals.max_player_health):
		curr_health = Globals.max_player_health
		return
	
	if(curr_health > 0):
		lives_changed.emit(curr_health)
	else:
		player_died.emit()
