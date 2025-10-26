extends ITransition
class_name Transition

var _anim_name:String
@export var anim_player:AnimationPlayer
@export var timer:Timer

var first_start:bool = true

func _ready() -> void:
	pass

func fade_out() -> void:
	if first_start == true:
		first_start = false
		_anim_name = "fade_out"
		timer.start()
		return
	
	anim_player.seek(1,true)
	anim_player.play("fade_out", -1, -1, true)
	
	await anim_player.animation_finished

func fade_in() -> void:
	anim_player.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_anim_name = anim_name
	timer.start()

func _on_button_pressed() -> void:
	fade_in()

func _on_button_2_pressed() -> void:
	fade_out()

func _on_timer_hold_timeout() -> void:
	if _anim_name == "fade_in":
		faded_in.emit()
	else:
		faded_out.emit()
