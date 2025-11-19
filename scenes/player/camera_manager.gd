extends Node3D

class_name CameraManager

var shaking := false
var base_rotation := Vector3.ZERO

func shake(duration := 0.2, magnitude := 0.5):
	if shaking:
		return
	shaking = true

	base_rotation = rotation

	var tween := create_tween()

	for i in range(10):
		var rand_rot = Vector3(
			deg_to_rad(randf_range(-magnitude, magnitude)),
			deg_to_rad(randf_range(-magnitude, magnitude)),
			0
		)
		tween.tween_property(self, "rotation", base_rotation + rand_rot, duration / 10)

	tween.tween_property(self, "rotation", base_rotation, 0.05)

	tween.finished.connect(func(): shaking = false)
