extends Node
class_name PlayerLocator

var player : PlayerObject

func init(playerObj:PlayerObject):
	player = playerObj
	
func distance_to_player(node:Node3D) -> float:
	return (node.global_position - player.global_position).length()

func get_player_pos_x_relativ_to(node:Node3D) -> float:
	return clampf((node.global_position.x- player.global_position.x) / 7.0,-1,1)
	
func player_behind_of(node:Node3D) -> bool:
	return (player.global_position.z - 12.0) >= node.global_position.z
