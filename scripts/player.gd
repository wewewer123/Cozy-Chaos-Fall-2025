extends CharacterBody3D
class_name PlayerObject

var max_health:int = 5
var curr_health:int = max_health

@export var leaf = 0
@export var max_velocity = 10
@export var move_speed: float = 15.0  

var max_lanes: int
var curr_lane: int
var lane_width: float = 25.0

var target_x: float
var spawner: Spawner

signal health_changed(newHealth : int)
signal player_died()

signal leaf_changed(change:int)

func init(s: Spawner) -> void:
	spawner = s 
	max_lanes = spawner.get_lane_count()
	curr_lane = max_lanes / 2
	target_x = spawner.get_lane_position(curr_lane).x

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		consume_movement(-1)
	if Input.is_action_just_pressed("right"):
		consume_movement(1)

func _physics_process(delta: float) -> void:
	# Smoothly move toward the target lane’s X
	position.x = lerp(position.x, target_x, move_speed * delta)

func consume_movement(direction: int) -> void:
	var new_lane = curr_lane + sign(direction)
	if new_lane >= 0 and new_lane < max_lanes:
		curr_lane = new_lane
		target_x = spawner.get_lane_position(curr_lane).x

func add_leaf(value:int) -> void:
	leaf += value
	leaf_changed.emit(value)

func incrementHealth() -> void:
	_changeHealth(1)
	
func decrementHealth() -> void:
	_changeHealth(-1)

func _changeHealth(value: int) -> void:
	curr_health += value
	
	if(curr_health > Globals.max_player_health):
		curr_health = Globals.max_player_health
		return
	
	if(curr_health > 0):
		health_changed.emit(value)
	else:
		player_died.emit()
