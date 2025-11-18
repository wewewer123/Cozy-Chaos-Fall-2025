extends ITransition
class_name Transition

var _anim_name:String
@export var anim_player:AnimationPlayer
@export var timer:Timer
@export var audio_source:AudioStreamPlayer2D
@export var audio_source_max_db:float
@export var audio_source_min_db:float
@export var audio_source_fade_out_offset:float

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
	play_sound()
	
	await anim_player.animation_finished

func fade_in() -> void:
	anim_player.play("fade_in")
	play_sound()

func play_sound() -> void:
	audio_source.play()
	
	var start_volume = audio_source_max_db
	var target_volume = -30.0
	var anim_length = anim_player.current_animation_length + audio_source_fade_out_offset
	var time_passed = 0.0

	while anim_player.is_playing():
		var delta := get_process_delta_time()
		time_passed += delta
		var t = clamp(time_passed / anim_length, 0.0, 1.0)
		audio_source.volume_db = lerp(start_volume, target_volume, t)
		await get_tree().process_frame

	audio_source.volume_db = target_volume
	audio_source.stop()

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
