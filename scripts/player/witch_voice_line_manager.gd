extends Node2D

var maxTime = 10;
var time = 18;

var index = 0;

@export var audioPlayer : AudioStreamPlayer2D

@export var voice_lines : Array[AudioStream]

func _ready() -> void:
	if(GameManager.current_level == 1):
		index = 0
	else:
		index = GameManager.current_level * 2

func _process(delta: float) -> void:
	time = time - delta;
	
	if(time <= 0):
		audioPlayer.stream = voice_lines[index]
		audioPlayer.play()
		index = (index + 1) % len(voice_lines)
		time = maxTime
