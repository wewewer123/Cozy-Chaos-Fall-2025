class_name FallingLeafParticles extends CPUParticles3D

@export var node_mover : NodeMover

signal falling_leaf_despawn(particle:FallingLeafParticles)

func _ready() -> void:
	node_mover.moved_out_of_sight.connect(falling_leaf_despawn.emit.bind(self))
