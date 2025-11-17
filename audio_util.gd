extends Node

func wait_audio_finished(audio_source:AudioStreamPlayer2D) -> void:
	while audio_source != null and audio_source.playing:
		await get_tree().process_frame

func fade_out_audio(audio_source: AudioStreamPlayer2D, duration: float = 1.0) -> void:
	var start_db := audio_source.volume_db
	var end_db := -80.0
	var time_passed := 0.0

	while time_passed < duration:
		var t = time_passed / duration
		audio_source.volume_db = lerp(start_db, end_db, t)
		time_passed += get_process_delta_time()
		await get_tree().process_frame

	audio_source.volume_db = end_db
	audio_source.stop()
