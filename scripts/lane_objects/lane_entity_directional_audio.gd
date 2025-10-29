extends Node3D
class_name DirectionalAudioManager

@export var soundeffect : AudioStream
@export var audio_streams : Array[AudioStreamPlayer2D]

var player_locator : PlayerLocator
var next_audio_index : int = 0

func init(playerLocator:PlayerLocator):
	player_locator = playerLocator
	_playDirectionalSound()

func _ready() -> void:
	for i in range(len(audio_streams)):
		audio_streams[i].stream = soundeffect

func _playDirectionalSound() -> void:
	playStream(audio_streams[next_audio_index])
	next_audio_index = (next_audio_index + 1) % len(audio_streams)

func playStream(audio_stream: AudioStreamPlayer2D) -> void:
	var startvol = -30
	var vol_range = 60
	
	audio_stream.play()
	audio_stream.volume_db = startvol
	
	while(player_locator.player_behind_of(self)):
		var vol_rangeume = vol_range - clamp(player_locator.distance_to_player(self) / 45.0 * vol_range, 0.0, vol_range);
		
		var effect = AudioServer.get_bus_effect(AudioServer.get_bus_index(audio_stream.bus), 0)
		effect.pan = player_locator.get_player_pos_x_relativ_to(self)
		
		if abs(effect.pan) < 0.2:
			audio_stream.volume_db = vol_rangeume + startvol + 5
		else:
			audio_stream.volume_db = vol_rangeume + startvol
			
		await get_tree().process_frame
	var t_start = 0.25
	var t = t_start
	var volume = audio_stream.volume_db
	while(t > 0):
		t -= get_process_delta_time()
		audio_stream.volume_db -= volume * (get_process_delta_time() / t_start)
		await get_tree().process_frame
	audio_stream.stop()
	
