extends Node3D
@export var max_lanes = 3
 
@onready var spawner: Spawner = $Spawner
@onready var player: PlayerObject = $Player
@onready var player_locator: PlayerLocator = $PlayerLocator

var _hud:HUD

func _ready() -> void:
	spawner.init()
	player.init(spawner)
	player_locator.init(player)
	
	GameManager.player = player
	_hud = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()
	_hud.init() # spawns hearts needs player to be set in GameManager
	add_child(_hud)
	
	player.health_changed.connect(_hud.on_player_health_changed)
	player.leaf_changed.connect(_hud.on_player_leaf_changed)
	player.player_died.connect(_hud.on_player_death)

func _on_lane_spawn_timer_timeout() -> void:
	spawner.spawn($Items, player_locator)
		
