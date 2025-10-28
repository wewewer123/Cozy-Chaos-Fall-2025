extends Label

func _ready() -> void:
	text = "0/" + str(Globals.max_leaf_count)
