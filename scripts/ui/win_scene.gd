extends Control
class_name WinScene

@onready var level_voice_line_manager:LevelVoiceLineManager = $LevelVoiceLineManager

func _ready() -> void:
	await level_voice_line_manager.play_beginnging_lines_async()
	await get_tree().create_timer(4).timeout
	GameManager.return_to_main_menu()
