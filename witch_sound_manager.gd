extends Node2D

var audioPlayers := []
var currentPlayerIndex = 0

@export var switchLanesSound : AudioStream
@export var bumpTreeSound : AudioStream
@export var bumpOnGhostSound : AudioStream
@export var pickUpLeafSound : AudioStream
@export var pickUpHeartSound : AudioStream
@export var oneHeartLeftSound : AudioStream
@export var playerHealSound : AudioStream

func _ready() -> void:
	audioPlayers = get_children()

func playSwitchLaneSound() -> void:
	_playStream(switchLanesSound)

func playBumpOnTrees() -> void:
	_playStream(bumpTreeSound)

func playBumpOnGhost() -> void:
	_playStream(bumpOnGhostSound)

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
