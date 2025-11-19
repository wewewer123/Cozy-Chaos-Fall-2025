extends Node3D
class_name DirectionalAudioManager

@export var soundeffect : AudioStream
@export var audio_streams : Array[AudioStreamPlayer2D]
@export	var start_volume_db = -15
@export var end_volume_db = 10
@export var audio_fade_out_seconds:float = 0.25
@export var start_delay_seconds:float = 0

var max_volume_offset = 10
var max_distance_player_obstacle = abs(Globals.object_spawn_distance) + max_volume_offset
var player_locator : PlayerLocator

func init(playerLocator:PlayerLocator, next_audio_bus_index:int):
	player_locator = playerLocator
	await get_tree().create_timer(start_delay_seconds).timeout
	_playDirectionalSound(next_audio_bus_index)

func stop():
	for stream in audio_streams:
		stream.stop()

func _ready() -> void:
	for i in range(len(audio_streams)):
		audio_streams[i].stream = soundeffect

func _playDirectionalSound(next_audio_bus_index:int) -> void:
	_playStream(audio_streams[next_audio_bus_index])

func _playStream(audio_stream: AudioStreamPlayer2D) -> void:
	audio_stream.volume_db = start_volume_db
	audio_stream.play()
	
	await _change_audio_stream_params_while_playing(audio_stream)
	await _fade_out_audiostream(audio_stream)
			
	audio_stream.stop()

func _get_panner_for_audio_stream(audio_stream: AudioStreamPlayer2D) -> AudioEffect:
	return AudioServer.get_bus_effect(AudioServer.get_bus_index(audio_stream.bus), 0)
	
func _change_audio_stream_params_while_playing(audio_stream: AudioStreamPlayer2D) -> void:
	var panner = _get_panner_for_audio_stream(audio_stream)
	var max_distance = max_distance_player_obstacle
	
	while player_locator.player_behind_of(self):
		var distance = player_locator.distance_to_player(self)
		var ratio = clamp(distance / max_distance, 0.0, 1.0)
		var next_volume_db = lerp(end_volume_db, start_volume_db , ratio)
		
		panner.pan = player_locator.get_x_direction_from_player(self)
		audio_stream.volume_db = next_volume_db
		
		await get_tree().process_frame

func _fade_out_audiostream(audio_stream: AudioStreamPlayer2D) -> void:
	var duration:float = audio_fade_out_seconds
	var start_volume = audio_stream.volume_db
	var target_volume = -80.0
	var time_passed = 0.0
	
	while time_passed < duration:
		var delta := get_process_delta_time()
		time_passed += delta
		var t = clamp(time_passed / duration, 0.0, 1.0)
		audio_stream.volume_db = lerp(start_volume, target_volume, t)
		await get_tree().process_frame
