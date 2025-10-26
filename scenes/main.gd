extends Node3D
@export var max_lanes = 3

var tree_inst: PackedScene = load("res://scenes/tree.tscn")


func _ready() -> void:
	$Player.max_lanes = max_lanes
	$Player.curr_lane = max_lanes / 2


func _on_timer_timeout() -> void:
	var tree = tree_inst.instantiate()
	tree.connect("player_collision", func(): $Player.lives -= 1)
	$Obstacles.add_child(tree)
	
