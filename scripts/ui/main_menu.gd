extends Control
class_name Menu

@export var options:Options
@export var menu:MainMenu

enum states {MENU, OPTIONS}
var _state:states = states.MENU

func _ready() -> void:
	$CenterContainer/Menu/CenterContainer/MenuButtonList/Start.grab_focus()

func _enter_tree() -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	var event_key := event as InputEventKey
	if event_key and event_key.pressed and event_key.keycode == KEY_TAB:
		if event_key.shift_pressed:
			find_prev_valid_focus().grab_focus.call_deferred()
		else:
			find_next_valid_focus().grab_focus.call_deferred()

func _input(event: InputEvent) -> void:
	_gui_input(event)

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
	$CenterContainer/Menu/CenterContainer/MenuButtonList/Start.grab_focus()

func _on_tutorial_pressed() -> void:
	pass # Replace with function body.
