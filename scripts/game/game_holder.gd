extends Node
# this sould be Game or Main but main already exist 
# this is for now an entry point for the game

func _ready() -> void:
	GameManager.set_scene_container(self)
	GameManager.set_state(GameManager.game_states.MENU)
