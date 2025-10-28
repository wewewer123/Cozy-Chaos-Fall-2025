extends Node3D
class_name TreeTextureSetter

func set_texture(value:Texture2D) -> void:
	for child in get_children():
		if child is Sprite3D:
			child.texture = value
