extends Node3D
class_name DirectionalAudioManager

@export var soundeffect : AudioStream
@export var leftAudio : AudioStreamPlayer2D
@export var centerAudio : AudioStreamPlayer2D
@export var rightAudio : AudioStreamPlayer2D

var player_locator : PlayerLocator

func init(playerLocator:PlayerLocator):
	player_locator = playerLocator
	_playDirectionalSound()

func _ready() -> void:
	leftAudio.stream = soundeffect
	centerAudio.stream = soundeffect
	rightAudio.stream = soundeffect

func _playDirectionalSound() -> void:
	if player_locator.position_is_left_of_player(self):
		leftAudio.play()
	elif player_locator.position_is_right_of_player(self):
		rightAudio.play()
	else:
		centerAudio.play()
	
