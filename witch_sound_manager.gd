extends Node2D

var audioPlayers := []
var currentPlayerIndex = 0

@export var switchLanesSound : AudioStream
@export var bumpTreeSound : AudioStream
@export var bumpOnGhostSound : AudioStream
@export var pickUpLeafSound : AudioStream
@export var pickUpHeart : AudioStream

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

func playPickUpHeart() -> void:
	_playStream(pickUpHeart)

func _playStream(nextStream: AudioStream) -> void:
	audioPlayers[currentPlayerIndex].stream = nextStream
	audioPlayers[currentPlayerIndex].play()
	currentPlayerIndex = (currentPlayerIndex + 1) % len(audioPlayers)
