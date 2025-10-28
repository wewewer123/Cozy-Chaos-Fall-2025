extends Node3D

@export var tree_collection : TreeFactory

@export var leftSpawnPoint : Node3D
@export var rightSpawnPoint : Node3D
@export var spawnInterval : float
@export var maxTreesPerSpawn : int = 3
@export var minTreesPerSpawn : int = 3

var tree_object_pool := []

var max_tree_pool_count = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_z = leftSpawnPoint.global_position.z
	var tempLeft =  leftSpawnPoint.position
	var tempRight =  rightSpawnPoint.position
	while spawn_z < 30:
		_spawnTrees(randi() % maxTreesPerSpawn + minTreesPerSpawn, tempRight, 1)
		_spawnTrees(randi() % maxTreesPerSpawn + minTreesPerSpawn, tempLeft, -1)
		spawn_z += (spawnInterval * 20)
		tempLeft.z = spawn_z
		tempRight.z = spawn_z

var timer = spawnInterval;

func _process(delta: float) -> void:
	timer -= delta
	
	if(timer <= 0):
		timer = spawnInterval
		_spawnTrees(randi() % maxTreesPerSpawn + minTreesPerSpawn, rightSpawnPoint.position, 1)
		_spawnTrees(randi() % maxTreesPerSpawn + minTreesPerSpawn, leftSpawnPoint.position, -1)

# TODO: Group all trees together into a node and move it
#		and not move all trees independently 
func _spawnTrees(count:int, pos:Vector3, spawn_direction:int):
	for i in range(count):
		var tree:Node3D = tree_collection.create_random_tree()
		add_child(tree)	
		tree.global_position = pos
		tree.global_position.x += i * 4 * spawn_direction + rand_range_float(-4, 4)
		tree.global_position.z += randf() * 2
		tree.scale = scale * (randf() * 4 + 2) 

func rand_range_float(minF: float, maxF: float) -> float:
	return randf() * (maxF - minF) + minF
