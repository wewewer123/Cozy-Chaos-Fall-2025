extends Node3D
class_name TreeDecoration

@export var texture_setter: TreeTextureSetter

func set_texture(texture:Texture2D):
	texture_setter.set_texture(texture)
