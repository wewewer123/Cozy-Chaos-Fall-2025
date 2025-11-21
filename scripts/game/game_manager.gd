extends Node

enum game_states { NULL, TUTORIAL, MENU, LEVEL1, LEVEL2, LEVEL3, LEVEL4, WIN }
var _curren_game_state:game_states = game_states.NULL

@export var transition:ITransition
@export var mainMenuScene:PackedScene
@export var tutorial:PackedScene
@export var levelScene1:PackedScene
@export var levelScene2:PackedScene
@export var levelScene3:PackedScene
@export var levelScene4:PackedScene
@export var winScene:PackedScene
@export var ttsId:String

var game_states_to_level 
	
# scene related code
var active_scene = null
var _scene_container:Node = null

var player:PlayerObject = null
var curr_lane_spawner:Spawner = null
var FIRST_LEVEL_INDEX = 1
var current_level:int = FIRST_LEVEL_INDEX

var is_quickplay = false

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices()
	if voices.size() > 0:
		ttsId = voices[0].id
		
	game_states_to_level = {
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
	
	if  Input.is_action_just_pressed("read_lives"):
		var message = "You have "+str(player.curr_health)+" lives left."
		DisplayServer.tts_speak(message, ttsId)
	
	if  Input.is_action_just_pressed("read_leaf"):
		var message = "You have collected "+str(player.leaf)+" leaves out of "+str(Globals.get_max_leaf_count())+"."
		DisplayServer.tts_speak(message, ttsId)
	
	if Input.is_action_just_pressed("next level"):
		GameManager.next_level()

func return_to_main_menu():
	set_state(game_states.MENU)
	current_level = FIRST_LEVEL_INDEX

func set_scene_container(scene_container:Node) -> void:
	assert( scene_container != null, "GameManager : scene_container must not be null") 
	_scene_container = scene_container

func set_state(new_state:game_states, force: bool = false) -> void:
	if _curren_game_state == new_state and not force:
		return
	
	transition.fade_out()
	_curren_game_state = new_state
	
	await transition.faded_out
	
	var nextScene = game_states_to_level[new_state].instantiate()
	_set_new_scene.call_deferred(nextScene)

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

func is_level_1() -> bool:
	return _curren_game_state == game_states.LEVEL1
