extends Node

var max_player_health = 3
var max_leaf_count = 15

var object_spawn_distance:float = 60

var debug_skip_radio = false

func get_spawn_time_for_level(value: GameManager.game_states) -> float:
	var base_time = _base_spawn_times.get(value)
	return base_time * lane_object_spawn_time_multiplier

var lane_object_spawn_time_multiplier = 5.0

var _base_spawn_times := {
	GameManager.game_states.LEVEL1: 1.0,
	GameManager.game_states.LEVEL2: 0.7,
	GameManager.game_states.LEVEL3: 0.5,
	GameManager.game_states.LEVEL4: 0.3,
}

# Current spawning timer speeds
#     Lv1: 1.0
#     Lv2: 0.7
#     Lv3: 0.5
#     Lv4: 0.3

# Optional speeds if the current is too fast
#     Lv1: 1.5
#     Lv2: 1.2
#     Lv3: 0.8
#     Lv4: 0.5
