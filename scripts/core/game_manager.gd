extends Node

signal on_state_transition(new_state:game_states)

# state related code
enum game_states { NULL, MENU, LEVEL, LEVEL2, TEST }
var _curren_game_state:game_states = game_states.NULL

@export var transition:ITransition

# scene related code
var active_scene = null
var _scene_container:Node = null

func _ready() -> void:
	pass

func set_scene_container(scene_container:Node) -> void:
	assert( scene_container != null, "GameManager : scene_container must not be null") 
	_scene_container = scene_container

func set_state(new_state:game_states) -> void:
	if _curren_game_state == new_state:
		return
	
	assert( _scene_container != null, "GameManager : _scene_container needs to be set call set_scene_container") 
	
	on_state_transition.emit(new_state)
	transition.fade_out()
	
	await transition.faded_out
	
	match new_state:
		game_states.MENU:
			_set_menu()
		game_states.LEVEL:
			_set_level()
		game_states.LEVEL2:
			pass

func _set_menu() -> void:
	var res:PackedScene = load("res://scripts/menu/main_menu.tscn")
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_level() -> void:
	var res:PackedScene = load("res://scenes/main.tscn")
	var new_scene = res.instantiate()
	call_deferred("_set_new_scene", new_scene)

func _set_new_scene(new_scene) -> void:
	if active_scene != null:
		active_scene.free()
		active_scene = null
	
	active_scene = new_scene
	_scene_container.add_child(active_scene)
	transition.fade_in()
