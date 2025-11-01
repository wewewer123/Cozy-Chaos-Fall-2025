extends Node3D
class_name TreeDecoration

@export var texture_setter: TreeTextureSetter

func set_texture(texture:Texture2D,emit:bool,amount:int):
	texture_setter.set_texture(texture)
	if(get_node_or_null("CPUParticles3D")!=null):
		$CPUParticles3D.emitting=emit
		$CPUParticles3D.amount=amount
