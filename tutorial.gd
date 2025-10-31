extends Node
class_name Tutorial

@export var tutorial_audio:TutorialAudioContainer

var _spawner:Spawner
var _audio_player:AudioStreamPlayer2D
var _player:PlayerObject

func start_and_wait(audio_player:AudioStreamPlayer2D, spawner:Spawner, player:PlayerObject) -> void:
	_audio_player = audio_player
	_spawner = spawner
	_player = player
	
	await play_tutorial()

func _play_voiceline(audio_stream:AudioStream) -> void:
	_audio_player.stream = audio_stream
	_audio_player.play()

func wait_audio_source_finished(audio_source:AudioStreamPlayer2D) -> void:
	while audio_source.playing:
		await get_tree().process_frame

func _wait_for_witch_voice_line():
	await wait_audio_source_finished(_audio_player)

func play_tutorial() -> void:
	_play_voiceline(tutorial_audio.Lvl1_Witch_01) #where are you
	await _wait_for_witch_voice_line() 
	
	await _wait_for_leaf_tutorial()
	#await get_tree().create_timer(3).timeout
	#await _wait_for_witch_voice_line()
	#await get_tree().create_timer(5).timeout
	#_play_voiceline(tutorial_audio.Lvl1_Witch_04)
	#await _wait_for_witch_voice_line()
	#_play_voiceline(tutorial_audio.Lvl1_Witch_06)
	#await _wait_for_witch_voice_line()
	#_play_voiceline(tutorial_audio.Lvl1_Witch_07)
	#await _wait_for_witch_voice_line()
	#_play_voiceline(tutorial_audio.Lvl1_Witch_08)
	#await _wait_for_witch_voice_line()
	#_play_voiceline(tutorial_audio.Lvl1_Witch_09)
	#await _wait_for_witch_voice_line()
	#_play_voiceline(tutorial_audio.Lvl1_Witch_10)
	#await _wait_for_witch_voice_line()

func _wait_for_leaf_tutorial():
	await get_tree().create_timer(1).timeout
	_play_voiceline(tutorial_audio.Lvl1_Witch_02) #what is this
	await _wait_for_witch_voice_line()
	_play_voiceline(tutorial_audio.Lvl1_Witch_03)
	await get_tree().create_timer(3).timeout
	
	while _player.leaf < 1:
		_spawner.spawn_leaf()
		await get_tree().create_timer(4).timeout
