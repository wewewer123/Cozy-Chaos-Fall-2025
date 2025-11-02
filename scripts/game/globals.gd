extends Node

var max_player_health = 3
var max_leaf_count = 15

var SPAWN_DIFFICULTY_MULTIPLIER = 1

var LANE_SPAWN_TIMERS := {
	GameManager.game_states.LEVEL1: 1.0 * SPAWN_DIFFICULTY_MULTIPLIER,
	GameManager.game_states.LEVEL2: 0.7 * SPAWN_DIFFICULTY_MULTIPLIER,
	GameManager.game_states.LEVEL3: 0.5 * SPAWN_DIFFICULTY_MULTIPLIER,
	GameManager.game_states.LEVEL4: 0.3 * SPAWN_DIFFICULTY_MULTIPLIER
}

var object_spawn_distance:float = 60

var debug_skip_radio = false

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
