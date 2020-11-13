extends Node2D
class_name Board

# Board accepts signals from segments and collects the data of a state of play
# It compares the state of the game with a winning combinations and informs of a winner

signal active_segment(position)
signal mouse_out_of_segment
signal segment_activated(segment)
signal segment_deacivated
signal player_won(shape)

# Enums here use the same names as the Segments of a board we use it to 
# be able to see if board state matches all winning combination 
enum Segments {
		TopLeft, TopCentre, TopRight, 
		MiddleLeft, MiddleCentre, MiddleRight
		BottomLeft, BottomCentre, BottomRight}


var active_segment: Area2D # used to prevent mouse from moving too fast and messing detection
var board_state_cross: Array = [0,0,0,0,0,0,0,0,0]
var board_state_circle: Array = [0,0,0,0,0,0,0,0,0]

func _ready() -> void:
	connect("player_won", GameManager, "_on_Board_player_won")

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


func _on_Segment_shape_placed_inside(segment:Area2D, shape) -> void:
	# Updates board_state for croses and circles depending a shape
	# if there is a winner sends a signal
	var current_board =_update_board_state(segment, shape)
	if _check_for_winner(current_board):
		emit_signal("player_won", shape)


func _update_board_state(segment:Area2D, shape) -> Array:
	# board_state_index checks enum Segments againts segment name to 
	# decide at what position to alter a Board State 
	var board_state_index = Segments.get(segment.name)
	var current_board: Array  
	if shape == "CROSS":
		board_state_cross[board_state_index] = 1
		current_board = board_state_cross
	if shape == "CIRCLE":
		board_state_circle[board_state_index] = 1
		current_board = board_state_circle
	return current_board


func _check_for_winner(board)-> bool:
	var winning_combinations: Array = [
			[1, 1, 1, 0, 0, 0, 0, 0, 0], # horizontal top line
			[0, 0, 0, 1, 1, 1, 0, 0, 0], # horizontal middle line
			[0, 0, 0, 0, 0, 0, 1, 1, 1], # horizontal bottom line
			[1, 0, 0, 1, 0, 0, 1, 0, 0], # vertical left line
			[0, 1, 0, 0, 1, 0, 0, 1, 0], # vertical middle line
			[0, 0, 1, 0, 0, 1, 0, 0, 1], # vertical right line
			[1, 0, 0, 0, 1, 0, 0, 0, 1], # diaganal left top to right bottom
			[0, 0, 1, 0, 1, 0, 1, 0, 0]] # diagnal right top to left bottom
			
	for combination in winning_combinations:
		var matching_results = 0
		var matching_results_needed_to_win = 3
		var index = 0 
		
		for outcome in combination:
			# we only care if 1s are matching between winning combination
			# and a board state
			if outcome == 1 and outcome == board[index]:
				matching_results += 1
			index += 1
		if matching_results == matching_results_needed_to_win:
			return true # end checking here and return true
	return false # if all checks fail return false

