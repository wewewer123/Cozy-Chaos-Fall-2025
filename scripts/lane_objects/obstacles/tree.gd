extends CollisionObject

enum TreeType { SUMMER, SEMI_AUTUMN, AUTUMN }

@export var summer_textures: Array[Texture2D]
@export var semi_autumn_textures: Array[Texture2D]
@export var autumn_textures: Array[Texture2D]

@export var treeType: TreeType

# Called when the node enters the scene tree for the first time.
func _ready():
	type = CollisionType.TREE
	#replace_sprites()

#TODO: Use tree factories here

#func replace_sprites() -> void:
	#var textures: Array[Texture2D]
	#
	#match type:
		#TreeType.SUMMER:
			#textures = summer_textures
		#TreeType.SEMI_AUTUMN:
			#textures = semi_autumn_textures
		#TreeType.AUTUMN:
			#textures = autumn_textures
	#
	#if textures.is_empty():
		#push_warning("No textures set for this tree type")
		#return
	#
	#var rng := RandomNumberGenerator.new()
	#rng.randomize()
	#var index := rng.randi_range(0, textures.size() - 1)
	#
	#for child in get_children():
		#if child is Sprite3D:
			#child.texture = textures[index]

func apply_effect(player: Node3D) -> void:
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
