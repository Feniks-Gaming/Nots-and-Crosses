extends Node2D
class_name Board

signal active_segment(position)
signal mouse_out_of_segment

var active_segment: Area2D

signal segment_activated(segment)
signal segment_deacivated

func _on_Segment_mouse_inside_area(segment:Area2D) -> void:
	#print(segment.name)
	#print(segment.global_position)
	active_segment = segment
	emit_signal("segment_activated",active_segment)



func _on_Segment_mouse_outside_area(segment:Area2D):
	if active_segment == segment:
		print("mouse outside")
		emit_signal("segment_deacivated")
	else:
		print("mouse moved to fast")


