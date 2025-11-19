extends Node2D

var maxTime = 10;
var time = 18;

var index = 0;

@export var audioPlayer : AudioStreamPlayer2D

@export var vl1_1 : AudioStream
@export var vl1_2 : AudioStream
@export var vl1_3 : AudioStream
@export var vl1_4 : AudioStream
@export var vl2_1 : AudioStream
@export var vl2_2 : AudioStream
@export var vl2_3 : AudioStream
@export var vl2_4 : AudioStream
@export var vl3_1 : AudioStream
@export var vl3_2 : AudioStream
@export var vl3_3 : AudioStream
@export var vl3_4 : AudioStream
@export var vl4_1 : AudioStream
@export var vl4_2 : AudioStream
@export var vl4_3 : AudioStream
@export var vl4_4 : AudioStream

var all_streams: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_streams = [
		vl1_1, vl1_2, vl1_3, vl1_4,
		vl2_1, vl2_2, vl2_3, vl2_4,
		vl3_1, vl3_2, vl3_3, vl3_4,
		vl4_1, vl4_2, vl4_3, vl4_4
	]
	
	if(GameManager.current_level == 1):
		index = 0
	else:
		index = GameManager.current_level * 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = time - delta;
	
	if(time <= 0):
		audioPlayer.stream = all_streams[index]
		audioPlayer.play()
		index = (index + 1) % len(all_streams)
		time = maxTime
