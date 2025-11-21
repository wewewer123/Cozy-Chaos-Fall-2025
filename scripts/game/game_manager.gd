extends Node

@export var transition:ITransition
@export var mainMenuScene:PackedScene
@export var tutorial:PackedScene
@export var levelScene1:PackedScene
@export var levelScene2:PackedScene
@export var levelScene3:PackedScene
@export var levelScene4:PackedScene
@export var winScene:PackedScene
@export var ttsId:String

enum game_states { NULL, TUTORIAL, MENU, LEVEL1, LEVEL2, LEVEL3, LEVEL4, WIN }
var _curren_game_state:game_states = game_states.NULL
var _game_states_to_level:Dictionary
	
var _active_scene = null
var _scene_container:Node = null

var current_level_index:int = 0

var is_quickplay = false

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices()
	if voices.size() > 0:
		ttsId = voices[0].id
		
	_game_states_to_level = {
		game_states.NULL: null, 
		game_states.TUTORIAL: tutorial,
		game_states.MENU: mainMenuScene,
		game_states.LEVEL1: levelScene1,
		game_states.LEVEL2: levelScene2,
		game_states.LEVEL3: levelScene3,
		game_states.LEVEL4: levelScene4,
		game_states.WIN: winScene}
		
func _process(_delta: float) -> void:
	if  Input.is_action_just_pressed("escape"):
		return_to_main_menu()
	if Input.is_action_just_pressed("next level"):
		next_level()

func start_story_mode():
	current_level_index = 0
	is_quickplay = false
	GameManager.set_state(game_states.TUTORIAL)

func start_quickplay_mode():
	current_level_index = 1
	is_quickplay = true
	GameManager.set_state(game_states.LEVEL1)
	
func return_to_main_menu():
	set_state(game_states.MENU)

func set_scene_container(scene_container:Node) -> void:
	assert( scene_container != null, "GameManager : scene_container must not be null") 
	_scene_container = scene_container

func set_state(new_state:game_states, force: bool = false) -> void:
	if _curren_game_state == new_state and not force:
		return
	
	_curren_game_state = new_state
	
	await play_transition_fade_out_async()
	
	var nextScene = _game_states_to_level[new_state].instantiate()
	_set_new_scene.call_deferred(nextScene)

func play_transition_fade_out_async():
	transition.fade_out()
	await transition.faded_out

func play_transition_fade_in_async():
	transition.fade_in()
	await transition.faded_in

func _set_new_scene(new_scene) -> void:
	if _active_scene != null:
		_active_scene.free()
		_active_scene = null
	
	_active_scene = new_scene
	_scene_container.add_child(_active_scene)
	
	await play_transition_fade_in_async()

func next_level():
	if current_level_index <= 3:
		current_level_index += 1
		
		match  current_level_index:
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

func is_level_1() -> bool:
	return _curren_game_state == game_states.LEVEL1
