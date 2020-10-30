extends Node2D
class_name Board

# Board accepts signals from segments and collects the data of a state of play
# It can be accessed by other classes to decide that is a current board state

signal active_segment(position)
signal mouse_out_of_segment

var active_segment: Area2D

signal segment_activated(segment)
signal segment_deacivated

func _on_Segment_mouse_inside_area(segment:Area2D) -> void:
	active_segment = segment
	emit_signal("segment_activated",active_segment)


func _on_Segment_mouse_outside_area(segment:Area2D):
	# We need this check to prevent mouse from moving too quickly to next segment
	# If mouse enters next segment and signal "segment_deacivated" is emited
	# shape would foolow mouse rather than stay inside a segment. This ensures
	# That signal is only emited if mouse leaves a segment but have't entered new
	# segment yet. 
	if active_segment == segment:
		emit_signal("segment_deacivated")


