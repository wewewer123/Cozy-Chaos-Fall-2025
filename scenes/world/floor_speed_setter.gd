extends MeshInstance3D

var mat:ShaderMaterial
var vec:Vector2 = Vector2.ZERO

func _ready() -> void:
	mat = get_surface_override_material(0)
	
func _process(delta: float):
	vec += Vector2(0, -Globals.cur_move_speed) * delta
	mat.set_shader_parameter("move_speed", vec)
#
