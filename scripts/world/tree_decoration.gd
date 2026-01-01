extends Node3D
class_name TreeDecoration

@export var node_mover : NodeMover
@export var texture_setter: TreeTextureSetter

signal tree_despawned(tree:TreeDecoration)

func _ready() -> void:
	node_mover.moved_out_of_sight.connect(tree_despawned.emit.bind(self))

func set_texture(texture:Texture2D):
	texture_setter.set_texture(texture)
