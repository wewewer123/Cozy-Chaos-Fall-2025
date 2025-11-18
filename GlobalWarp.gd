extends Node

var current_value := 0.0

func _ready():
	set_next_warp()

func set_next_warp():
	var next_value = randf_range(-0.01, 0.01)

	var tween = create_tween()
	tween.tween_method(
		Callable(self, "_set_warp"),
		current_value,
		next_value,
		10.0
	)

	tween.finished.connect(set_next_warp)
	current_value = next_value

func _set_warp(value):
	RenderingServer.global_shader_parameter_set("WarpAmount", value)
