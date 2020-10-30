extends Area2D

# Segments make each cell of a board players play on.
# Segments connect to board and inform it via signals whem mouse is inside the
# the segment

signal mouse_inside_area(segment)
signal mouse_outside_area(segment)

onready var board: Node2D = find_parent("Board")


func _ready() -> void:
	connect("mouse_entered",self,"_on_Segment_mouse_entered")
	connect("mouse_inside_area", board, "_on_Segment_mouse_inside_area")
	
	connect("mouse_exited",self,"_on_Segment_mouse_exited")
	connect("mouse_outside_area", board, "_on_Segment_mouse_outside_area")


func _on_Segment_mouse_entered() -> void:
	emit_signal("mouse_inside_area", self)


func _on_Segment_mouse_exited() -> void:
	emit_signal("mouse_outside_area",self)
