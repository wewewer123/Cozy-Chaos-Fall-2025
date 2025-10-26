extends Node3D

class_name BroomOscillator

@export var amplitude: float = 0.5
@export var frequency: float = 2.0
@export var lean_amount: float = 15.0
@export var lean_smooth: float = 5.0

var _time: float = 0.0
var _base_y: float
var _target_tilt: Vector3 = Vector3.ZERO

func _ready() -> void:
	_base_y = global_position.y

func _process(delta: float) -> void:
	# === Bobbing motion ===
	_time += delta
	var offset_y = sin(_time * TAU * frequency) * amplitude
	global_position.y = _base_y + offset_y
	
	var input_dir := Vector2.ZERO
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
		
	_target_tilt = Vector3(
		input_dir.y * lean_amount,
		180,
		input_dir.x * lean_amount
	)

	var current_rot = rotation_degrees
	current_rot = current_rot.lerp(_target_tilt, delta * lean_smooth)
	rotation_degrees = current_rot
