extends Area3D



# Called when the node enters the scene tree for the first time.
func _ready():
	var rng:= RandomNumberGenerator.new()
	
	lane_spawn(rng.randi_range(-1, 1))
	#position = Vector3(lane, 0, -10)

func _process(delta):
	position += Vector3(0, 0, 1.0)*20*delta

func lane_spawn(direction: int) -> void:
	position = Vector3((sign(direction)*10), 0, -20)
	
#func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
#	collision.emit()


func _on_body_entered(body: Node3D) -> void:
	$Player.lives -= 1
