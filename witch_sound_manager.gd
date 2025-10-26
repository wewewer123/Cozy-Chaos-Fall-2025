extends AudioStreamPlayer2D

@export var audioPlayer : AudioStreamPlayer2D

@export var switchLanesSound : AudioStream
@export var bumpTreeSound : AudioStream

func playSwitchLaneSound() -> void:
	_playStream(switchLanesSound)

func playBumpOnTrees() -> void:
	_playStream(bumpTreeSound)
	
	
func _playStream(nextStream: AudioStream) -> void:
	audioPlayer.stream = nextStream
	audioPlayer.play()
