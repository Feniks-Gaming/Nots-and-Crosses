extends Area2D

# Segments make each cell of a board players play on.
# Segments connect to board and inform it via signals whem mouse is inside the
# the segment


var can_detect_mouse = true

signal mouse_inside_area(segment)
signal mouse_outside_area(segment)

onready var board: Node2D = find_parent("Board")


func _ready() -> void:
	#Mouse entered
	connect("mouse_entered",self,"_on_mouse_entered")
	connect("mouse_inside_area", board, "_on_Segment_mouse_inside_area")
	#Mouse exited
	connect("mouse_exited",self,"_on_mouse_exited")
	connect("mouse_outside_area", board, "_on_Segment_mouse_outside_area")
	# Area entered
	connect("area_entered",self,"_on_area_entered")

func _on_mouse_entered() -> void:
	if can_detect_mouse:
		emit_signal("mouse_inside_area", self)


func _on_mouse_exited() -> void:
	print("mouse exited")
	emit_signal("mouse_outside_area",self)


func _on_area_entered(area: Area2D) -> void:
	can_detect_mouse = false



