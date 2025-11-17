extends Node3D

class_name LaneObjectCollection

func remove_all_lane_objects():
	for child in get_children():
			child.queue_free()
