extends Node3D
class_name Spawner

@export var tree_inst: PackedScene
@export var ghost_inst: PackedScene
@export var leaf_inst: PackedScene
@export var heart_inst: PackedScene
@export var fade_in_time := 1.0
@export var spawn_strategie: SpawnStrategie = SpawnStrategie.Single

@onready var lane_spawn_timer: LaneSpawnTimer = $LaneSpawnTimer

enum SpawnStrategie { Single, Pair }

var lanes: Array[Marker3D]
var rng := RandomNumberGenerator.new()

var player_locat:PlayerLocator
var object_parent:Node

var next_audio_bus_index = 0
var audio_pan_effect_busses = 3

func _ready() -> void:
	position.z = -Globals.object_spawn_distance

func init(spawned_object_parent: Node, player_locator:PlayerLocator) -> void:
	self.player_locat = player_locator
	self.object_parent = spawned_object_parent
	
	rng.randomize()
	lanes = []
	for child in get_children():
		if child is Marker3D:
			lanes.append(child)

func get_lane_count() -> int:
	return lanes.size()

func get_lane_position(index: int) -> Vector3:
	return lanes[index].global_position

func _pick_lane(exclude_index: int = -1) -> int:
	var count:= lanes.size()
	
	if count == 0:
		push_warning("Spawner has no lanes.")
		return -1
		
	if count == 1:
		return 0;
	
	var index := rng.randi_range(0, count - 1)
	
	if exclude_index >= 0 && count > 1:
		while index == exclude_index:
			index = rng.randi_range(0, count - 1)
	
	return index

func _spawn_packed_at(packed: PackedScene, parent: Node, lane_index: int) -> Node3D:
	var node := packed.instantiate()
	var base_pos := get_lane_position(lane_index)
	parent.add_child(node)
	node.global_position = base_pos
	return node

# Allow caller to force a lane, otherwise pick one (optionally excluding)
func spawn_item(parent: Node, lane_index: int = -1, exclude_lane: int = -1) -> CollisionObject:
	var index := lane_index if lane_index >= 0 else _pick_lane(exclude_lane)
	var packed: PackedScene = heart_inst if rng.randi_range(0, 3) == 0 else leaf_inst
	return _spawn_packed_at(packed, parent, index)

func spawn_obstacle(parent: Node, lane_index: int = -1, exclude_lane: int = -1) -> CollisionObject:
	var index := lane_index if lane_index >= 0 else _pick_lane(exclude_lane)
	var packed: PackedScene = tree_inst if rng.randi_range(0, 1) == 0 else ghost_inst
	return _spawn_packed_at(packed, parent, index)

# One-call convenience: spawns an item and an obstacle on DISTINCT lanes.
func spawn() -> void:
	match spawn_strategie:
		SpawnStrategie.Single:
			spawn_single()
		SpawnStrategie.Pair:
			spawn_pair()
	
	next_audio_bus_index = (next_audio_bus_index + 1) % audio_pan_effect_busses

func spawn_single() -> void:
	var lane_object:CollisionObject
	
	if randi_range(0, 2) == 0:
		lane_object = spawn_item(object_parent, _pick_lane())
	else:
		lane_object = spawn_obstacle(object_parent, _pick_lane())
	
	lane_object.init(player_locat, next_audio_bus_index)
	
	await fade_in([lane_object])

func spawn_pair() -> void:
	var lane_item := _pick_lane()
	var lane_obstacle := _pick_lane(lane_item)

	var item := spawn_item(object_parent, lane_item)
	var obstacle := spawn_obstacle(object_parent, lane_obstacle)

	item.init(player_locat, next_audio_bus_index)
	obstacle.init(player_locat, next_audio_bus_index)
	
	await fade_in([item,obstacle])
	
func fade_in(objects : Array[CollisionObject]) -> void:
	var t := 0.0
	set_alpha_for_objects(objects,0)
	while t < fade_in_time:
		t += get_process_delta_time()
		set_alpha_for_objects(objects, clamp(t / fade_in_time, 0.0, 1.0))
		await get_tree().process_frame
		
func set_alpha_for_objects(objects:Array[CollisionObject], alpha:float):
	for child in objects:
		child.set_texture_alpha(alpha)

func start_spawning() -> void:
	spawn()
	lane_spawn_timer.start_timer()

func stop_spawning() -> void:
	lane_spawn_timer.stop_timer()

func _on_lane_spawn_timer_timeout() -> void:
	spawn()
