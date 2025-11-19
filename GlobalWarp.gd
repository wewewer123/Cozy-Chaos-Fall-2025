extends Node

var current_value := 0.0
var x = 0
var noise := FastNoiseLite.new()

func get_small_noise(value):
	var n = noise.get_noise_1d(value)
	return n * 0.01

func _ready():
	x = 0
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	set_next_warp()

func set_next_warp():
	var next_value = get_small_noise(x)
	x = x + 1
	var tween = create_tween()
	tween.tween_method(
		Callable(self, "_set_warp"),
		current_value,
		next_value,
		2
	)

	tween.finished.connect(set_next_warp)
	current_value = next_value

func _set_warp(value):
	RenderingServer.global_shader_parameter_set("WarpAmount", value)
