extends Node3D

@export var particle_system_scene:PackedScene
@export var spawn_point_left:Node3D
@export var spawn_point_right:Node3D
@export var spawn_timer:Timer

var all_particles : Array[FallingLeafParticles]

func _ready() -> void:
	for i in range(80):
		var particles:FallingLeafParticles = particle_system_scene.instantiate()
		particles.visible = false
		all_particles.append(particles)
		add_child(particles)
	
	_initial_spawn()
	spawn_timer.timeout.connect(_spawn)

func _spawn():
	_spawn_on_point(spawn_point_left)
	_spawn_on_point(spawn_point_right)

func _spawn_on_point(spawn_point:Node3D):
	_spawn_on_point_with_z_offset(spawn_point, 0)
	
func _spawn_on_point_with_z_offset(spawn_point:Node3D, z_offset:float):
	var particles:FallingLeafParticles = all_particles.pop_back()
	
	if particles == null:
		particles = particle_system_scene.instantiate()
	
	particles.visible = true
	particles.global_position = spawn_point.global_position
	particles.position.z += z_offset
	particles.falling_leaf_despawn.connect(_on_particle_despawn)

func _on_particle_despawn(particle:FallingLeafParticles) -> void:
	particle.falling_leaf_despawn.disconnect(_on_particle_despawn)
	all_particles.append(particle)

func _initial_spawn():
	for i in range(20):
		_spawn_on_point_with_z_offset(spawn_point_left, i * 5)
	
	for i in range(20):
		_spawn_on_point_with_z_offset(spawn_point_right, i * 5)
