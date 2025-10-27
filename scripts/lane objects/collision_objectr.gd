extends Area3D
class_name CollisionObject

enum CollisionType { TREE, GHOST, LEAF, HEART }
@export var type: CollisionType

const DESPAWN_Y_VALUE: float = 30

signal collided_with_player(colisions_type: int, player: Node)

func _on_body_entered(body: Node3D) -> void:
	if is_player(body):
		apply_effect(body)
		emit_signal("collided_with_player", type, body)

func _process(delta):
	position += Vector3(0, 0, 1.0)*20*delta
	if position.z > DESPAWN_Y_VALUE:
		queue_free()

func is_player(body: Node3D) -> bool:
	return body.is_in_group("Player")

func apply_effect(player: Node3D) -> void:
	#virtual method override
	push_error("apply_effect not implemented")
