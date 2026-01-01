class_name NodeMover extends Node

const DESPAWN_Y_VALUE: float = 70

var parent: Node3D  

signal moved_out_of_sight

func _ready() -> void:
	parent = get_parent()

func _process(delta):
	parent.global_position += Vector3(0, 0, 1.0) * Globals.cur_move_speed * delta
	
	if parent.global_position.z > DESPAWN_Y_VALUE:
		moved_out_of_sight.emit()
