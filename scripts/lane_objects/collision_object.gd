extends Area3D
class_name CollisionObject

enum CollisionType { TREE, GHOST, LEAF, HEART }
@export var type: CollisionType
@export var textureSetter : TreeTextureSetter
@onready var directionalAudio : DirectionalAudioManager = $LaneEntityDirectionalAudio

signal collided_with_player(colisions_type: int, player: Node)

func init(player_locator:PlayerLocator, next_audio_bus_index:int):
	if(directionalAudio != null):
		directionalAudio.init(player_locator, next_audio_bus_index)

func set_texture_alpha(value : float) -> void:
	textureSetter.set_alpha(value)

func _on_body_entered(body: Node3D) -> void:
	if is_player(body):
		apply_effect(body)
		emit_signal("collided_with_player", type, body)

func is_player(body: Node3D) -> bool:
	return body.is_in_group("Player")

func fade_in(fade_in_time:float):
	var t := 0.0
	set_texture_alpha(0)
	while t < fade_in_time:
		t += get_process_delta_time()
		set_texture_alpha(clamp(t / fade_in_time, 0.0, 1.0))
		await get_tree().process_frame

func apply_effect(_player: Node3D) -> void:
	textureSetter.queue_free()
	create_tween().tween_method(set_move_speed, 0, Globals.max_move_speed, 1.5)

func set_move_speed(value:float):
	Globals.cur_move_speed = value
