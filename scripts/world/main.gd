extends Node3D
@export var max_lanes = 3
@export var fade_in_time = 1
 
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

func _on_lane_spawn_timer_timeout() -> void:
	var result := spawner.spawn_pair($Items, $Obstacles)
	var item : CollisionObject = result["item"]
	var obstacle : CollisionObject = result["obstacle"]
	
	await fade_in(item,obstacle)
	
	item.connect("collided_with_player", self._on_collision)
	obstacle.connect("collided_with_player", self._on_collision)
	
func fade_in(item, obstacle : CollisionObject) -> void:
	var t := 0.0
	item.set_texture_alpha(0)
	obstacle.set_texture_alpha(0)
	while t < fade_in_time:
		t += get_process_delta_time()
		item.set_texture_alpha(clamp(t / fade_in_time, 0.0, 1.0))
		obstacle.set_texture_alpha(clamp(t / fade_in_time, 0.0, 1.0))
		await get_tree().process_frame

func _on_collision(collision_type: int, player: Node3D) -> void:
	# You don’t touch player stats here — that’s handled in apply_effect().
	# This is just for cross-cutting concerns like sound, particles, UI.
	pass
