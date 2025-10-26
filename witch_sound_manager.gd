extends AudioStreamPlayer2D

@export var audioPlayer : AudioStreamPlayer2D

@export var switchLanesSound : AudioStream

func playSwitchLaneSound() -> void:
	audioPlayer.stream = switchLanesSound
	audioPlayer.play()
