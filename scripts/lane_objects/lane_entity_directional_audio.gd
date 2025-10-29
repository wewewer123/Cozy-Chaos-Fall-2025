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
	# await _fade_out_audiostream(audio_stream)
			
	audio_stream.stop()

func _get_panner_for_audio_stream(audio_stream: AudioStreamPlayer2D) -> AudioEffect:
	return AudioServer.get_bus_effect(AudioServer.get_bus_index(audio_stream.bus), 0)
	
func _change_audio_stream_params_while_playing(audio_stream: AudioStreamPlayer2D) -> void:
	var panner = _get_panner_for_audio_stream(audio_stream)
	
	while(player_locator.player_behind_of(self)):
		var distanceRatio = player_locator.distance_to_player(self) / max_distance_player_obstacle * end_volume_db
		var next_volume_db = end_volume_db - clamp(distanceRatio, 0.0, end_volume_db);
		panner.pan = player_locator.get_player_pos_x_relativ_to(self)
		audio_stream.volume_db = next_volume_db + start_volume_db
		await get_tree().process_frame
		
func _fade_out_audiostream(audio_stream: AudioStreamPlayer2D) -> void:
	var t_cur = audio_fade_out_seconds
	var volume = audio_stream.volume_db
	while(t_cur > 0):
		t_cur -= get_process_delta_time()
		audio_stream.volume_db -= volume * (get_process_delta_time() / audio_fade_out_seconds)
		await get_tree().process_frame
