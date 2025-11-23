extends Node3D
class_name TreeTextureSetter

@export var texture : Texture2D

func _ready() -> void:
	if(texture != null):
		set_texture(texture)

func set_texture(value:Texture2D) -> void:
	var array = get_children()
	array.append(self)
	
	for child in array:
		if child is Sprite3D and child.material_override != null:
			set_texture_and_material(value, child.material_override)
			return

func set_texture_and_material(value:Texture2D, material:ShaderMaterial) -> void:
	var array = get_children()
	array.append(self)
	
	for child in array:
		if child is Sprite3D:
			var mat = material.duplicate()
			child.material_override = mat
			mat.set_shader_parameter("albedo_texture", value)
			child.texture = value

func set_alpha(value:float) -> void:
	var array = get_children()
	array.append(self)
	
	for child in array:
		if child is Sprite3D:
			child.material_override.set_shader_parameter("alpha", value)
