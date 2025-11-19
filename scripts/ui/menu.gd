extends MarginContainer
class_name MainMenu

@export var start_button:Button
@export var continue_button:Button
@export var reset_level_button:Button
@export var options_button:Button
@export var exit_button:Button

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	GameManager.current_level = 0
	GameManager.is_quickplay = false
	GameManager.set_state(GameManager.game_states.TUTORIAL)
	
func _on_visibility_changed() -> void:
	$CenterContainer/MenuButtonList/Start.grab_focus()

func _on_quickplay_pressed() -> void:
	GameManager.current_level = 1
	GameManager.is_quickplay = true
	GameManager.set_state(GameManager.game_states.LEVEL1)
