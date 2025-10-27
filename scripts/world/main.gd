extends Node3D
@export var max_lanes = 3

@onready var spawner: Spawner = $Spawner
@onready var player: PlayerObject = $Player

var _hud:HUD

func _ready() -> void:
	spawner.init()
	player.init(spawner)
	
	GameManager.player = player
	_hud = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()
	_hud.init() # spawns hearts needs player to be set in GameManager
	add_child(_hud)
	
	player.health_changed.connect(_hud.on_player_health_changed)
	player.leaf_changed.connect(_hud.on_player_leaf_changed)
	player.player_died.connect(_hud.on_player_death)

func _on_timer_timeout() -> void:
	var result := spawner.spawn_pair($Items, $Obstacles)
	var item : CollisionObject = result["item"]
	var obstacle : CollisionObject = result["obstacle"]
	
	item.connect("collided_with_player", self._on_collision)
	obstacle.connect("collided_with_player", self._on_collision)

func _on_collision(collision_type: int, player: Node3D) -> void:
	# You don’t touch player stats here — that’s handled in apply_effect().
	# This is just for cross-cutting concerns like sound, particles, UI.
	pass
	
#func _on_timer_timeout() -> void:
	#var rng:= RandomNumberGenerator.new() 
	#
	#var tree = tree_inst.instantiate()
	#var ghost = ghost_inst.instantiate()
	#var leaf = leaf_inst.instantiate()
	#var heart = heart_inst.instantiate()
	#
	#tree.connect("player_collision", func(): $Player.curr_health -= 1)
	#ghost.connect("player_collision", func(): $Player.curr_health -= 1)
	#leaf.connect("player_collision", func(): $Player.leaf += 1)
	#heart.connect("player_collision", func(): $Player.heart += 1)
	#
	#if rng.randi_range(0, 3) == 0:
		#$Items.add_child(heart)
	#else:
		#$Items.add_child(leaf)
	#
	#if rng.randi_range(0, 1) == 0:
		#$Obstacles.add_child(tree)
	#else:
		#$Obstacles.add_child(ghost)
	
