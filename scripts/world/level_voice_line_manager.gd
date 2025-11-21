extends AudioStreamPlayer2D

class_name LevelVoiceLineManager

@export var _level_beginning_voice_lines:Array[AudioStream]
@export var _level_middle_voice_lines:Array[AudioStream]
@export var _level_end_voice_lines:Array[AudioStream]

var skip_all_voicelines = GameManager.is_quickplay

var begin_vl_played = false
var middle_vl_played = false
var end_vl_played = false

func play_beginnging_lines_async():
	await _handle_voice_lines_async(_level_beginning_voice_lines, begin_vl_played)
	begin_vl_played = true

func play_middle_lines_async():
	await _handle_voice_lines_async(_level_middle_voice_lines, middle_vl_played)
	middle_vl_played = true

func play_ending_lines_async():
	await _handle_voice_lines_async(_level_end_voice_lines, end_vl_played)
	end_vl_played = true

func has_mid_level_voice_lines() -> bool:
	return len(_level_middle_voice_lines) > 0 

func has_end_level_voice_lines() -> bool:
	return len(_level_end_voice_lines) > 0 

func _handle_voice_lines_async(voice_lines:Array[AudioStream], skip_current:bool = false):
	if skip_all_voicelines or skip_current:
		return
	
	if len(voice_lines) == 0: 
		return
	
	for line in voice_lines:
		stream = line
		play()
		await AudioUtil.wait_audio_finished(self)
		await get_tree().create_timer(0.5).timeout
