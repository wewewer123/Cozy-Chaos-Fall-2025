extends Node

func wait_audio_finished(audio_source:AudioStreamPlayer2D) -> void:
	while audio_source.playing:
		await get_tree().process_frame
