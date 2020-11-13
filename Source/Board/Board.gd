extends Node2D
class_name Board

# Board accepts signals from segments and collects the data of a state of play
# It can be accessed by other classes to decide that is a current board state

signal active_segment(position)
signal mouse_out_of_segment
signal segment_activated(segment)
signal segment_deacivated

enum Segments {
		TopLeft, TopCentre, TopRight, 
		MiddleLeft, MiddleCentre, MiddleRight
		BottomLeft, BottomCentre, BottomRight}


var active_segment: Area2D
var board_state_cross: Array = [null,null,null,null,null,null,null,null,null]
var board_state_circle: Array = [null,null,null,null,null,null,null,null,null]

func _on_Segment_mouse_inside_area(segment:Area2D) -> void:
	active_segment = segment
	emit_signal("segment_activated",active_segment)


func _on_Segment_mouse_outside_area(segment:Area2D) -> void:
	# We need this check to prevent mouse from moving too quickly to next segment
	# If mouse enters next segment and signal "segment_deacivated" is emited
	# shape would foolow mouse rather than stay inside a segment. This ensures
	# That signal is only emited if mouse leaves a segment but have't entered new
	# segment yet. 
	if active_segment == segment:
		emit_signal("segment_deacivated")
		print("mouse out")


func _on_Segment_shape_placed_inside(segment:Area2D, shape) -> void:
	var board_state_index = Segments.get(segment.name)
	if shape == "CROSS":
		board_state_cross[board_state_index] = shape
	if shape == "CIRCLE":
		board_state_circle[board_state_index] = shape
	print(board_state_cross)


# posible combinations
# [yes,yes,yes
# no, no, no,
# no, no, no]

# [no, no, no,
# yes, yes,yes,
# no, no, no]

#[no, no, no,
# no, no, no,
# yes, yes, yes]

# [yes, no, no,
# yes, no, no,
# yes, no, no]

# [no, yes, no,
# no, yes, no,
# no, yes, no]

# [no, no, yes,
# no, no, yes,
# no, no, yes]

# [yes,no,no
# no, yes,no
# no, no , yes]

# [no,no,yes
# no, yes,no
# yes, no , no]
