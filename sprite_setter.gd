extends Node

@export var texture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Sprite3D:
			child.texture = texture
