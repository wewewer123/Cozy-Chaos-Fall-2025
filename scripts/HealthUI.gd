extends CanvasLayer

@export var health_container : HBoxContainer
@export var heart_scene : PackedScene

var hearts := []

func _ready() -> void:
	for i in range(Globals.max_player_health):
		var heart = heart_scene.instantiate()
		health_container.add_child(heart)
		hearts.append(heart)


func _on_player_lives_changed(curr_health: int) -> void:
	for i in range(len(hearts)):
		hearts[i].visible = i < curr_health
