extends Node3D

@export var texture: Texture2D

func _ready() -> void:
	for child in get_children():
		if child is TreeDecoration:
			child.set_texture(texture)
