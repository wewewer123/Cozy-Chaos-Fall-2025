extends Node
class_name LaneSpawnTimer

signal costum_timeout

var time = 1
var t = time
var is_stopped = true

func _process(delta: float) -> void:
	if is_stopped:
		return
	
	t -= delta * (Globals.cur_move_speed / Globals.max_move_speed)
	
	if t <= 0:
		t = time
		costum_timeout.emit()

func init(_wait_t:float):
	time = _wait_t
	
func start_timer() -> void:
	is_stopped = false
	
func stop_timer() -> void:
	is_stopped = true
