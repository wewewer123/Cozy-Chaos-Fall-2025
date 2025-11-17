extends Node
class_name Tutorial

#TODO: Stop all coroutines if user goes back to main menu via escape

@export var tutorial_audio:TutorialAudioContainer

@onready var _spawner:Spawner = $LaneSpawner
@onready var _audio_player:AudioStreamPlayer2D = $LevelVoiceLineManager
@onready var _player:PlayerObject = $Player
@onready var _player_locator:PlayerLocator = $PlayerLocator
@onready var lane_object_parent:LaneObjectCollection = $LaneObjectCollection
@onready var hud:HUD = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()

func _ready() -> void:
	GameManager.player = _player
	GameManager.curr_lane_spawner = _spawner
	
	hud.init()
	_spawner.init(lane_object_parent, _player_locator)
	_player.init(_spawner)
	_player_locator.init(_player)
	
	add_child(hud)
	
	await _play_tutorial_async()

func _play_tutorial_async() -> void:
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_01) #where are you
	await _wait_for_leaf_tutorial()
	await _wait_for_tree_tutorial()
	await _wait_for_outro()

func _wait_for_leaf_tutorial():
	var callable:Callable = _play_voiceline.bind(tutorial_audio.Lvl1_Witch_04)	
	_player.object_missed_signal.connect(callable)
	
	await get_tree().create_timer(1).timeout
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_02)
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_03)
	
	while _player.leaf < 1:
		_spawner.spawn_leaf()
		await get_tree().create_timer(4).timeout
		await _wait_for_witch_voice_line()
		
	_player.object_missed_signal.disconnect(callable)
	
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_06)
	await get_tree().create_timer(1).timeout
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Radio_02)
	await get_tree().create_timer(1).timeout
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_07)

func _wait_for_outro():
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_10)
	_spawner.spawn_leaf()
	await get_tree().create_timer(4).timeout
	_spawner.spawn_leaf()
	await get_tree().create_timer(5).timeout
	GameManager.set_state(GameManager.game_states.MENU)

func _wait_for_tree_tutorial():
	await get_tree().create_timer(1).timeout	
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_08)
	
	_spawner.spawn_tree()
	await get_tree().create_timer(4).timeout
	await _play_and_wait_witch_voice_line(tutorial_audio.Lvl1_Witch_09)
	
	var count = 0
	while(count < 2):
		_player.set_health_to_max()
		_spawner.spawn_tree()
		await get_tree().create_timer(4).timeout
		count = count + 1

func _play_voiceline(audio_stream:AudioStream) -> void:
	_audio_player.stream = audio_stream
	_audio_player.play()

func _wait_for_witch_voice_line():
	await AudioUtil.wait_audio_finished(_audio_player)

func _play_and_wait_witch_voice_line(stream:AudioStream):
	_play_voiceline(stream)
	await _wait_for_witch_voice_line() 
