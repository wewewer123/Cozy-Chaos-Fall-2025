extends Node

var max_player_health = 3

var object_spawn_distance:float = 60

func get_spawn_time_for_level(value: GameManager.game_states) -> float:
	var base_time = _base_spawn_times.get(value)
	return base_time * lane_object_spawn_time_multiplier

var lane_object_spawn_time_multiplier = 2

var _base_spawn_times := {
	GameManager.game_states.LEVEL1: 1.0,
	GameManager.game_states.LEVEL2: 0.7,
	GameManager.game_states.LEVEL3: 0.5,
	GameManager.game_states.LEVEL4: 0.3
}

func get_leaf_count_for_level(value: GameManager.game_states) -> int:
	var base_count = _base_leaf_counts.get(value, 0)
	return base_count * max_leaf_count_multiplier

func get_max_leaf_count():
	return get_leaf_count_for_level(GameManager._curren_game_state)

var max_leaf_count_multiplier = 10

var _base_leaf_counts := {
	GameManager.game_states.TUTORIAL: 1,
	GameManager.game_states.LEVEL1: 1,
	GameManager.game_states.LEVEL2: 2,
	GameManager.game_states.LEVEL3: 3,
	GameManager.game_states.LEVEL4: 4
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
