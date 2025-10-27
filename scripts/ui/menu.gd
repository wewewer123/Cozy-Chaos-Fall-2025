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
	GameManager.set_state(GameManager.game_states.LEVEL)

func _on_continue_pressed() -> void:
	pass

func _on_visibility_changed() -> void:
	$CenterContainer/MenuButtonList/Start.grab_focus()
