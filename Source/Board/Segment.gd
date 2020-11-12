extends Area2D

# Segments make each cell of a board players play on.
# Segments connect to board and inform it via signals whem mouse is inside the
# the segment


var can_detect_mouse = true

signal mouse_inside_area(segment)
signal mouse_outside_area(segment)
signal shape_placed_inside(segment,shape_type)

onready var board: Node2D = find_parent("Board")


func _ready() -> void:
	#Mouse entered
	connect("mouse_entered",self, "_on_mouse_entered")
	connect("mouse_inside_area", board, "_on_Segment_mouse_inside_area")
	#Mouse exited
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("mouse_outside_area", board, "_on_Segment_mouse_outside_area")
	# Area entered
	connect("area_entered", self, "_on_area_entered")
	connect("shape_placed_inside", board, "_on_Segment_shape_placed_inside")

func _on_mouse_entered() -> void:
	if can_detect_mouse:
		emit_signal("mouse_inside_area", self)


func _on_mouse_exited() -> void:
	emit_signal("mouse_outside_area",self)


func _on_area_entered(area: Area2D) -> void:
	if area is Placed_Shape:
		can_detect_mouse = false
		var current_shape = Utility.return_dictionary_key_from_value(area.Shapes, area.shape)
		emit_signal("shape_placed_inside", self, current_shape)



