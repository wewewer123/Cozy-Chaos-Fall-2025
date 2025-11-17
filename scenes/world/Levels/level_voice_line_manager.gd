extends AudioStreamPlayer2D

class_name LevelVoiceLineManager

@export var _level_beginning_voice_lines:Array[AudioStream]
@export var _level_middle_voice_lines:Array[AudioStream]
@export var _level_end_voice_lines:Array[AudioStream]

func play_beginnging_lines_async():
	await _play_voice_lines_async(_level_beginning_voice_lines)

func play_middle_lines_async():
	await _play_voice_lines_async(_level_middle_voice_lines)

func play_ending_lines_async():
	await _play_voice_lines_async(_level_end_voice_lines)

func _play_voice_lines_async(voice_lines:Array[AudioStream]):
	if len(voice_lines) == 0: 
		return
	
	for line in voice_lines:
		stream = line
		play()
		await AudioUtil.wait_audio_finished(self)
