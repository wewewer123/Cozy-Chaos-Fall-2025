extends Node3D
@export var max_lanes = 3

func _ready() -> void:
	$Player.max_lanes = max_lanes
	$Player.curr_lane = max_lanes / 2
