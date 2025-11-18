@tool
extends Node3D
class_name TreeTextureSetter

@export var texture : Texture2D

func _ready() -> void:
	if(texture != null):
		set_texture(texture)

func set_texture(value:Texture2D) -> void:
	for child in get_children():
		if child is Sprite3D:
			var mat=child.material_override.duplicate()
			child.material_override=mat
			mat.set_shader_parameter("albedo_texture", value)
			child.texture = value
			
func set_alpha(value:float) -> void:
	var array = get_children()
	array.append(self)
	
	for child in array:
		if child is Sprite3D:
			child.modulate.a = value
