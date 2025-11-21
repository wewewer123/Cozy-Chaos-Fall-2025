extends CanvasLayer
class_name HUD

@export var hearth_container:HBoxContainer
@export var empty_hearth_container:HBoxContainer

var hear_res:PackedScene = load("res://scenes/ui/ingame hud/hearth_full.tscn")
var empty_hear_res:PackedScene = load("res://scenes/ui/ingame hud/hearth_empty.tscn")

func _ready() -> void:
	$Timer.start()

func init(level_headline:String) -> void:
	$MarginContainer/CenterContainer/Label.text = level_headline
	for x in range(Globals.max_player_health):
		add_heart()

func on_player_health_changed(change:int) -> void:
	if change > 0:
		add_heart()
	elif change < 0:
		remove_hearth()

func on_player_leaf_changed(new_leaf_count:int) -> void:
	$Control/MarginContainer2/HBoxContainer/Label.text = str(new_leaf_count) + "/" + str(Globals.get_max_leaf_count())

func add_heart() -> void:
	if empty_hearth_container.get_child_count() > 0:
		empty_hearth_container.get_child(0).queue_free()
		
	hearth_container.add_child(hear_res.instantiate())
	
func remove_hearth() -> void:
	if hearth_container.get_child_count() > 0:
		hearth_container.get_child(0).queue_free()
	empty_hearth_container.add_child(empty_hear_res.instantiate())

func on_player_death() -> void:
	hide()
	
func show_hud():
	show()

func _on_timer_timeout() -> void:
	$MarginContainer/CenterContainer/Label.hide()
