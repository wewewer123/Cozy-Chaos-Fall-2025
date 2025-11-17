extends AudioStreamPlayer2D

class_name LevelVoiceLineManager

@export var _level_beginning_voice_lines:Array[AudioStream]
@export var _level_middle_voice_lines:Array[AudioStream]
@export var _level_end_voice_lines:Array[AudioStream]

var skip_voicelines = GameManager.is_quickplay

func play_beginnging_lines_async():
	await _play_voice_lines_async(_level_beginning_voice_lines)

func play_middle_lines_async():
	await _play_voice_lines_async(_level_middle_voice_lines)

func play_ending_lines_async():
	await _play_voice_lines_async(_level_end_voice_lines)

func has_mid_level_voice_lines() -> bool:
	return len(_level_middle_voice_lines) > 0 

func _play_voice_lines_async(voice_lines:Array[AudioStream]):
	if skip_voicelines:
		return
	
	if len(voice_lines) == 0: 
		return
	
	for line in voice_lines:
		stream = line
		play()
		await AudioUtil.wait_audio_finished(self)
		await get_tree().create_timer(0.5).timeout
