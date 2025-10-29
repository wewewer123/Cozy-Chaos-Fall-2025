extends Node2D

var audioPlayers := []
var currentPlayerIndex = 0

var curr_time = 5
var interval = 5

@export var switchLanesSound : AudioStream
@export var wallOfTreeSound : AudioStream
@export var hurtByTreeSound : AudioStream
@export var hurtByGhostSound : AudioStream
@export var pickUpLeafSound : AudioStream
@export var pickUpHeartSound : AudioStream
@export var oneHeartLeftSound : AudioStream
@export var playerHealSound : AudioStream

func _ready() -> void:
	audioPlayers = get_children()

func playSwitchLaneSound() -> void:
	_playStream(switchLanesSound)

func playWallOfTrees() -> void:
	_playStream(wallOfTreeSound)

func playHurtByTree() -> void:
	_playStream(hurtByTreeSound)

func playHurtByGhost() -> void:
	_playStream(hurtByGhostSound)

func playPickUpLeaf() -> void:
	_playStream(pickUpLeafSound)

func playpickUpHeartSound() -> void:
	_playStream(pickUpHeartSound)

func playHealSound() -> void:
	_playStream(playerHealSound)

func playOnHealthLeftSound() -> void:
	_playStream(oneHeartLeftSound)

func _playStream(nextStream: AudioStream) -> void:
	audioPlayers[currentPlayerIndex].stream = nextStream
	audioPlayers[currentPlayerIndex].play()
	currentPlayerIndex = (currentPlayerIndex + 1) % len(audioPlayers)
