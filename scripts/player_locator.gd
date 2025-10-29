extends Node
class_name PlayerLocator

var player : PlayerObject

func init(playerObj:PlayerObject):
	player = playerObj
	
func get_player_x_position() -> float:
	return player.position.x

func position_is_left_of_player(node:Node3D) -> bool:
	return round(node.global_position.x) < round(player.global_position.x)

func position_is_right_of_player(node:Node3D) -> bool:
	return round(node.global_position.x) > round(player.global_position.x)

func distance_to_player(node:Node3D) -> float:
	return (node.global_position - player.global_position).length()
