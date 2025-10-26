extends ITransition
class_name Transition

var _anim_name:String

func fade_out() -> void:
	$AnimationPlayer.seek(1,true)
	$AnimationPlayer.play("fade_out", -1, -1, true)
	
	await $AnimationPlayer.animation_finished

func fade_in() -> void:
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_anim_name = anim_name
	$TimerHold.start()

func _on_button_pressed() -> void:
	fade_in()

func _on_button_2_pressed() -> void:
	fade_out()

func _on_timer_hold_timeout() -> void:
	if _anim_name == "fade_in":
		faded_in.emit()
	else:
		faded_out.emit()
