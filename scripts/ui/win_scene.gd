extends Control
class_name WinScene

@onready var level_voice_line_manager:LevelVoiceLineManager = $LevelVoiceLineManager

func _ready() -> void:
	level_voice_line_manager.play_beginnging_lines_async()
