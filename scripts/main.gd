extends Node3D
@export var max_lanes = 3

var tree_inst: PackedScene = load("res://scenes/tree.tscn")
var ghost_inst: PackedScene = load("res://scenes/ghost.tscn")
var leaf_inst: PackedScene = load("res://scenes/oakleaf.tscn")
var heart_inst: PackedScene = load("res://scenes/heart.tscn")


func _ready() -> void:
	$Player.max_lanes = max_lanes
	$Player.curr_lane = max_lanes / 2


func _on_timer_timeout() -> void:
	var rng:= RandomNumberGenerator.new() 
	
	var tree = tree_inst.instantiate()
	var ghost = ghost_inst.instantiate()
	var leaf = leaf_inst.instantiate()
	var heart = heart_inst.instantiate()
	tree.connect("player_collision", func(): $Player.lives -= 1)
	ghost.connect("player_collision", func(): $Player.lives -= 1)
	leaf.connect("player_collision", func(): $Player.leaf += 1)
	heart.connect("player_collision", func(): $Player.heart += 1)
	
	if rng.randi_range(0, 3) == 0:
		$Items.add_child(heart)
	else:
		$Items.add_child(leaf)
	
	if rng.randi_range(0, 1) == 0:
		$Obstacles.add_child(tree)
	else:
		$Obstacles.add_child(ghost)
	
