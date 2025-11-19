extends Node3D
class_name Spawner

@export var level: GameManager.game_states = GameManager.game_states.LEVEL1
@export var tree_inst: PackedScene
@export var ghost_inst: PackedScene
@export var leaf_inst: PackedScene
@export var heart_inst: PackedScene
@export var fade_in_time := 1.0

@onready var lane_spawn_timer: LaneSpawnTimer = $LaneSpawnTimer

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
	var timer:LaneSpawnTimer = $LaneSpawnTimer
	timer.init(Globals.get_spawn_time_for_level(level))
	timer.costum_timeout.connect(spawn)
	
	rng.randomize()
	lanes = []
	for child in get_children():
		if child is Marker3D:
			lanes.append(child)

func get_level():
	return level

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
	node.init(player_locat, next_audio_bus_index)
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
	spawn_single()
	next_audio_bus_index = (next_audio_bus_index + 1) % audio_pan_effect_busses

func spawn_single() -> void:
	var lane_object:CollisionObject
	
	if randi_range(0, 2) == 0:
		lane_object = spawn_item(object_parent, _pick_lane())
	else:
		lane_object = spawn_obstacle(object_parent, _pick_lane())
	
	lane_object.fade_in(fade_in_time)

func spawn_pair() -> void:
	var lane_object:CollisionObject
	var lane_object_2:CollisionObject
	
	var lane = 1
	var lane2 = 1
	while lane == lane2:
		lane = _pick_lane()
		lane2 = _pick_lane()
	
	if randi_range(0, 2) == 0:
		lane_object = spawn_item(object_parent, lane)
	else:
		lane_object = spawn_obstacle(object_parent, lane)
	
	if randi_range(0, 2) == 0:
		lane_object_2 = spawn_item(object_parent, lane2)
	else:
		lane_object_2 = spawn_obstacle(object_parent, lane2)
	
	lane_object.fade_in(fade_in_time)
	lane_object_2.fade_in(fade_in_time)

func start_spawning() -> void:
	lane_spawn_timer.start_timer()

func stop_spawning() -> void:
	lane_spawn_timer.stop_timer()

func spawn_tree() -> void:
	_spawn_packed_random(tree_inst)

func spawn_ghost() -> void:
	_spawn_packed_random(ghost_inst)

func spawn_leaf() -> void:
	_spawn_packed_random(leaf_inst)

func spawn_heart() -> void:
	_spawn_packed_random(heart_inst)

func spawn_tree_on_lane(lane:int) -> void:
	_spawn_packed_on_lane(tree_inst, lane)

func _spawn_packed_on_lane(packed: PackedScene, lane:int) -> void:
	var lane_object = _spawn_packed_at(packed, object_parent, lane)
	lane_object.fade_in(fade_in_time)

func _spawn_packed_random(packed: PackedScene) -> void:
	_spawn_packed_on_lane(packed, randi_range(0,len(lanes) - 1))
