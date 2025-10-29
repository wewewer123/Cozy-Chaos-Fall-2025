extends Node

var max_player_health = 5
var max_leaf_count = 5

var SPAWN_DIFFICULTY_MULTIPLAYER = 2

var LANE_SPAWN_TIMERS := {
	GameManager.game_states.LEVEL1: 1.0 * SPAWN_DIFFICULTY_MULTIPLAYER,
	GameManager.game_states.LEVEL2: 0.95 * SPAWN_DIFFICULTY_MULTIPLAYER,
	GameManager.game_states.LEVEL3: 0.9 * SPAWN_DIFFICULTY_MULTIPLAYER,
	GameManager.game_states.LEVEL4: 0.8 * SPAWN_DIFFICULTY_MULTIPLAYER
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
