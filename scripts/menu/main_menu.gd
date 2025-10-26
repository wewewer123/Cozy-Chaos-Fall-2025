extends Control
class_name Menu

@export var options:Options
@export var menu:MainMenu

enum states {MENU, OPTIONS}
var _state:states = states.MENU

func _ready() -> void:
	pass

func _enter_tree() -> void:
	pass

func change_state(state:states) -> void:
	if _state == state:
		return
	
	match state:
		states.MENU:
			handle_menu_state_transiiotn(state)
		states.OPTIONS:
			handle_option_state_transiiotn(state)

func handle_option_state_transiiotn(new_state:states) -> void:
	if _state == states.MENU:
		menu.hide()
		options.show()
	
	_state = new_state

func handle_menu_state_transiiotn(new_state:states) -> void:
	if _state == states.OPTIONS:
		menu.show()
		options.hide()
	
	_state = new_state

func _on_options_pressed() -> void:
	change_state(states.OPTIONS)

func _on_menu_back_pressed() -> void:
	change_state(states.MENU)
