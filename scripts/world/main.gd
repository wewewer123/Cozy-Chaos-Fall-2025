extends Node3D
 
class_name LevelManager

@onready var player:PlayerObject = $Player
@onready var spawner:Spawner = $LaneSpawner
@onready var player_locator:PlayerLocator = $PlayerLocator
@onready var hud:HUD = load("res://scenes/ui/ingame hud/HUD.tscn").instantiate()
@onready var lane_object_parent:LaneObjectCollection = $LaneObjectCollection
@onready var level_voice_line_manager:LevelVoiceLineManager = $LevelVoiceLineManager
@onready var backgroundmusic:AudioStreamPlayer2D = $Backgroundmusic

func _ready() -> void:	
	GameManager.player = player
	GameManager.curr_lane_spawner = spawner
	
	hud.init("Level - " + str(GameManager.current_level) + "/4")
	spawner.init(lane_object_parent, player_locator)
	player.init(spawner)
	player_locator.init(player)
	
	add_child(hud)
	
	player.health_changed.connect(hud.on_player_health_changed)
	player.leaf_changed.connect(hud.on_player_leaf_changed)
	player.player_died.connect(hud.on_player_death)
	
	player.leaf_changed.connect(on_player_leaf_changed)
	player.player_died.connect(on_player_death)
	
	await level_voice_line_manager.play_beginnging_lines_async()
	spawner.start_spawning()

func on_player_leaf_changed(new_leaf_count:int):
	if new_leaf_count == Globals.get_max_leaf_count():
		lane_object_parent.remove_all_lane_objects()
		spawner.stop_spawning()
		if level_voice_line_manager.has_end_level_voice_lines():
			await AudioUtil.fade_out_audio(backgroundmusic)
		await level_voice_line_manager.play_ending_lines_async()
		GameManager.next_level()
	elif _should_play_mid_level_voice_lines(new_leaf_count):
		spawner.stop_spawning()
		lane_object_parent.remove_all_lane_objects()
		await level_voice_line_manager.play_middle_lines_async()
		spawner.start_spawning()

func _should_play_mid_level_voice_lines(new_leaf_count:int) -> bool:
	return (
		!GameManager.is_quickplay and
		level_voice_line_manager.has_mid_level_voice_lines() and
		new_leaf_count == roundi(Globals.get_max_leaf_count() / 2.0))

func skip_voice_lines():
	level_voice_line_manager.enable_skip_voicelines()

func on_player_death() -> void:
	lane_object_parent.remove_all_lane_objects()
	spawner.stop_spawning()
	player.reset_stats()
	backgroundmusic.stop()
	
	await GameManager.play_transition_fade_out_async()
	GameManager.play_transition_fade_in_async()
	
	backgroundmusic.play()
	spawner.start_spawning()
	hud.show_hud()
