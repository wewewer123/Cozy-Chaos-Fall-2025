extends Node3D
class_name Spawner

@export var tree_inst: PackedScene
@export var ghost_inst: PackedScene
@export var leaf_inst: PackedScene
@export var heart_inst: PackedScene

var lanes: Array[Marker3D]
var rng := RandomNumberGenerator.new()

func init() -> void:
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
func spawn_pair(item_parent: Node, obstacle_parent: Node) -> Dictionary:
	var lane_item := _pick_lane()
	var lane_obstacle := _pick_lane(lane_item)

	var item := spawn_item(item_parent, lane_item)
	var obstacle := spawn_obstacle(obstacle_parent, lane_obstacle)

	return {
		"item": item,
		"item_lane": lane_item,
		"obstacle": obstacle,
		"obstacle_lane": lane_obstacle
	}
