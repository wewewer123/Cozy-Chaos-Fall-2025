extends Node3D
 
@onready var player:PlayerObject = $Player
@onready var spawner:Spawner = $LaneSpawner
@onready var player_locator:PlayerLocator = $PlayerLocator
@onready var hud:HUD = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()
@onready var lane_object_parent:LaneObjectCollection = $LaneObjectCollection

func _ready() -> void:	
	GameManager.player = player
	GameManager.curr_lane_spawner = spawner
	
	hud.init()
	spawner.init(lane_object_parent, player_locator)
	player.init(spawner)
	player_locator.init(player)
	
	add_child(hud)
	
	player.health_changed.connect(hud.on_player_health_changed)
	player.leaf_changed.connect(hud.on_player_leaf_changed)
	player.player_died.connect(hud.on_player_death)
	
	player.leaf_changed.connect(on_player_leaf_changed)
	player.player_died.connect(on_player_death)
	
func on_player_leaf_changed(new_leaf_count:int):
	if new_leaf_count == Globals.get_max_leaf_count():
		lane_object_parent.remove_all_lane_objects()
		GameManager.next_level()

func on_player_death() -> void:
	lane_object_parent.remove_all_lane_objects()
