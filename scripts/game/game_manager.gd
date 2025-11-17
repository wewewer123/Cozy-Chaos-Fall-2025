extends Node

signal on_state_transition(new_state:game_states)

# state related code
enum game_states { NULL, TUTORIAL, MENU, LEVEL1, LEVEL2, LEVEL3, LEVEL4, WIN }
var _curren_game_state:game_states = game_states.NULL

@export var transition:ITransition

@export var radio_audio_source:AudioStreamPlayer2D

@export var radioLevel1:AudioStream
@export var radioLevel2:AudioStream
@export var radioLevel3:AudioStream
@export var radioLevel4:AudioStream
@export var radioEnd:AudioStream

@export var mainMenuScene:PackedScene
@export var tutorial:PackedScene
@export var levelScene1:PackedScene
@export var levelScene2:PackedScene
@export var levelScene3:PackedScene
@export var levelScene4:PackedScene
@export var winScene:PackedScene

@export var ttsId:String

# scene related code
var active_scene = null
var _scene_container:Node = null

var player:PlayerObject = null
var curr_lane_spawner:Spawner = null
var FIRST_LEVEL_INDEX = 1
var current_level:int = FIRST_LEVEL_INDEX

func _playStream(nextStream: AudioStream) -> void:
	if(Globals.debug_skip_radio):
		await get_tree().process_frame
		return

	radio_audio_source.stream = nextStream
	radio_audio_source.play()

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices()
	if voices.size() > 0:
		ttsId = voices[0].id
		
func _process(_delta: float) -> void:
	if  Input.is_action_just_pressed("escape"):
		_resetGameState()
		set_state(game_states.MENU)
	
	if  Input.is_action_just_pressed("read_lives"):
		var message = "You have "+str(player.curr_health)+" lives left."
		DisplayServer.tts_speak(message, ttsId)
	
	if  Input.is_action_just_pressed("read_leaf"):
		var message = "You have collected "+str(player.leaf)+" leaves out of "+str(Globals.get_max_leaf_count())+"."
		DisplayServer.tts_speak(message, ttsId)
	

func _resetGameState():
	current_level = FIRST_LEVEL_INDEX
	radio_audio_source.stop()

func set_scene_container(scene_container:Node) -> void:
	assert( scene_container != null, "GameManager : scene_container must not be null") 
	_scene_container = scene_container

func set_state(new_state:game_states, force: bool = false) -> void:
	if _curren_game_state == new_state and not force:
		return
	
	assert( _scene_container != null, "GameManager : _scene_container needs to be set call set_scene_container") 
	
	if curr_lane_spawner != null:
		curr_lane_spawner.stop_spawning()
	on_state_transition.emit(new_state)
	transition.fade_out()
	_curren_game_state = new_state
	
	await transition.faded_out
	
	match new_state:
		game_states.MENU:
			_set_menu()
		game_states.TUTORIAL:
			_set_level()
			_set_tutorial()
		game_states.LEVEL1:
			_set_level()
		game_states.LEVEL2:
			_set_level2()
		game_states.LEVEL3:
			_set_level3()
		game_states.LEVEL4:
			_set_level4()
			curr_lane_spawner.start_spawning()
		game_states.WIN:
			_set_win()

func _set_tutorial():
	var tutorialObject = tutorial.instantiate()
	add_child(tutorialObject)
	await get_tree().process_frame
	await tutorialObject.start_and_wait(radio_audio_source, curr_lane_spawner, player)
		
func wait_audio_source_finished(audio_source:AudioStreamPlayer2D) -> void:
	while audio_source.playing:
		await get_tree().process_frame

func _play_voiceline(audio_stream:AudioStream) -> void:
	radio_audio_source.stream = audio_stream
	radio_audio_source.play()

func _set_menu() -> void:
	var res:PackedScene = mainMenuScene
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_level() -> void:
	var res:PackedScene = levelScene1
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_level2() -> void:
	var res:PackedScene = levelScene2
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_level3() -> void:
	var res:PackedScene = levelScene3
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)
	
func _set_level4() -> void:
	var res:PackedScene = levelScene4
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_win() -> void:
	var res:PackedScene = winScene
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_new_scene(new_scene) -> void:
	if active_scene != null:
		active_scene.free()
		active_scene = null
	
	active_scene = new_scene
	_scene_container.add_child(active_scene)
	transition.fade_in()

func next_level():
	if current_level <= 3:
		current_level += 1
		
		match  current_level:
			1:
				set_state(GameManager.game_states.LEVEL1)
			2:
				set_state(GameManager.game_states.LEVEL2)
			3:
				set_state(GameManager.game_states.LEVEL3)
			4: 
				set_state(GameManager.game_states.LEVEL4)
		
	else:
		set_state(GameManager.game_states.WIN)

func on_player_death():
	curr_lane_spawner.stop_spawning()
	match  current_level:
		1:
			set_state(GameManager.game_states.LEVEL1, true)
		2:
			set_state(GameManager.game_states.LEVEL2, true)
		3:
			set_state(GameManager.game_states.LEVEL3, true)
		4:
			set_state(GameManager.game_states.LEVEL4, true)
