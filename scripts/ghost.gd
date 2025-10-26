extends Area3D

signal player_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng:= RandomNumberGenerator.new()
	
	lane_spawn(rng.randi_range(-1, 1))

func _process(delta):
	position += Vector3(0, 0, 1.0)*20*delta

func lane_spawn(direction: int) -> void:
	position = Vector3((sign(direction)*10), 0, -20)

func _on_body_entered(body: Node3D) -> void:
	emit_signal("player_collision")
