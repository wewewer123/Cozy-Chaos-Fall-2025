extends CharacterBody3D
class_name PlayerObject

var curr_health:int = Globals.max_player_health

@export var leaf:int = 0
@export var witch_audio_manager:Node
@export var max_velocity = 10
@export var move_speed: float = 15.0  

signal object_missed_signal

var max_lanes: int
var curr_lane: int
var lane_width: float = 25.0

var target_x: float
var spawner: Spawner

signal health_changed(newHealth : int)
signal player_died()

signal leaf_changed(new_leaf_count:int)

func init(s: Spawner) -> void:
	$"Witch/AnimationPlayer".play("ArmatureAction")
	spawner = s 
	max_lanes = spawner.get_lane_count()
	curr_lane = max_lanes / 2
	target_x = spawner.get_lane_position(curr_lane).x

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		consume_movement(-1)
	if Input.is_action_just_pressed("right"):
		consume_movement(1)

func consume_movement(direction: int) -> void:
	var new_lane = curr_lane + sign(direction)
	if new_lane >= 0 and new_lane < max_lanes:
		curr_lane = new_lane
		target_x = spawner.get_lane_position(curr_lane).x
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "position:x", target_x, .15)
		witch_audio_manager.playSwitchLaneSound()
	else:
		witch_audio_manager.playWallOfTrees()

func add_leaf(value:int) -> void:
	leaf += value
	leaf_changed.emit(leaf)

func incrementHealth() -> void:
	_changeHealth(1)
	witch_audio_manager.playHealSound()

func decrementHealth() -> void:
	_changeHealth(-1)

func _changeHealth(value: int) -> void:
	if value == 0:
		return
		
	curr_health += value
	
	if(curr_health > Globals.max_player_health):
		curr_health = Globals.max_player_health
		return
	
	if(curr_health == 1):
		witch_audio_manager.playOnHealthLeftSound()
	
	if(curr_health > 0):
		health_changed.emit(value)
	else:
		witch_audio_manager.playDeathSound()
		player_died.emit()
		GameManager.on_player_death()

func set_health_to_max():
	_changeHealth(Globals.max_player_health - curr_health)

func has_max_health() -> bool:
	return curr_health >= Globals.max_player_health

func _on_missed_objects_collider_area_entered(area: Area3D) -> void:
	if(area is CollisionObject):
		object_missed_signal.emit()
