extends Node3D
 
func _ready() -> void:
	var player: PlayerObject = $Player
	var spawner:Spawner = $LaneSpawner
	var player_locator:PlayerLocator = $PlayerLocator
	var hud:HUD = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()
	
	GameManager.player = player
	
	hud.init()
	spawner.init($Items, player_locator)
	player.init(spawner)
	player_locator.init(player)
	
	add_child(hud)
	
	player.health_changed.connect(hud.on_player_health_changed)
	player.leaf_changed.connect(hud.on_player_leaf_changed)
	player.player_died.connect(hud.on_player_death)
