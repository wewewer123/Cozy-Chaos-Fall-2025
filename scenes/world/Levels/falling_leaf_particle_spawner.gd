extends Node3D

@export var particle_system_scene:PackedScene
@export var spawn_point_left:Node3D
@export var spawn_point_right:Node3D
@export var spawn_timer:Timer

func _ready() -> void:
	_initial_spawn()
	spawn_timer.timeout.connect(_spawn)

func _spawn():
	_spawn_on_point(spawn_point_left)
	_spawn_on_point(spawn_point_right)

func _spawn_on_point(spawn_point:Node3D):
	_spawn_on_point_with_z_offset(spawn_point, 0)
	
func _spawn_on_point_with_z_offset(spawn_point:Node3D, z_offset:float):
	var particles:Node3D = particle_system_scene.instantiate()
	particles.position.z += z_offset
	spawn_point.add_child(particles)

func _initial_spawn():
	for i in range(20):
		_spawn_on_point_with_z_offset(spawn_point_left, i * 5)
	
	for i in range(20):
		_spawn_on_point_with_z_offset(spawn_point_right, i * 5)
	
