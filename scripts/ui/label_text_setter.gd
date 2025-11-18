extends Label

func _ready() -> void:
	var leaf_count= Globals.get_leaf_count_for_level(GameManager._curren_game_state)
	
	text = "0/" + str(leaf_count)
