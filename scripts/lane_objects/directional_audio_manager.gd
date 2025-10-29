extends Node3D
class_name DirectionalAudioManager

@export var soundeffect : AudioStream
@export var audio_streams : Array[AudioStreamPlayer2D]
@export	var start_volume_db = -30
@export var end_volume_db = 60
@export var audio_fade_out_seconds = 0.25

var max_distance_player_obstacle = 45.0

var player_locator : PlayerLocator
var next_audio_index : int = 0

func init(playerLocator:PlayerLocator):
	player_locator = playerLocator
	await get_tree().create_timer(start_delay_seconds).timeout
	_playDirectionalSound()

func _ready() -> void:
	for i in range(len(audio_streams)):
		audio_streams[i].stream = soundeffect

func _playDirectionalSound() -> void:
	_playStream(audio_streams[next_audio_index])
	next_audio_index = (next_audio_index + 1) % len(audio_streams)

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
