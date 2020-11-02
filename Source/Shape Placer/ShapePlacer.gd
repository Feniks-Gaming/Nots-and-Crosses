extends Icon
class_name ShapePlacer

# Shape placer is created when AvaliableShape is clicked
# It can follow mouse and stay inside appropriate board segments if mouse
# is inside them.

signal destroyed
signal placed

var can_move: bool = true
var can_create_shapes: bool = false
var segment_to_stay_in: Area2D

onready var avaliable_shapes: Array = GameManager.avaliable_shapes

func _ready():
	_connect_to_shapes()
	_connect_to_board()


func _process(delta: float) -> void:
	toggle_movement()
	create_shape_on_board()
	destroy()


func _connect_to_shapes() -> void:
	# Connects to avaliable shapes signals to be able to activate and deactivate
	# them when created and destroyed
	for shape in avaliable_shapes:
		connect("destroyed", shape, "_on_ShapePlacer_destroyed")
		connect("placed", shape, "_on_ShapePlacer_placed")


func _connect_to_board() -> void:
	# Connects to board so it can use information from it about which segemnt
	# mouse is in at a time
	var scene: Node2D = get_tree().current_scene
	var board:Board = scene.find_node("Board")
	board.connect("segment_activated",self, "_on_Board_segment_activated")
	board.connect("segment_deacivated",self,"_on_Board_segment_deactivated")


func toggle_movement()-> void:
	if can_move:
		follow_mouse()
	else:
	 global_position = segment_to_stay_in.global_position


func follow_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	position = mouse_pos


func _on_Board_segment_activated(segment)-> void:
	# Prevents following a mouse when inside a segment. 
	segment_to_stay_in = segment
	can_move = false
	can_create_shapes = true


func _on_Board_segment_deactivated() -> void:
	# Triggered when mouse leaves a segment on a board
	can_move = true
	can_create_shapes = false


func destroy() -> void:
	if Input.is_action_just_pressed("mouse_right_click"):
		emit_signal("destroyed")
		queue_free()


func create_shape_on_board() -> void:
	if can_create_shapes:
		if Input.is_action_just_pressed("mouse_left_click"):
			var shape_to_create = Icon.new()
			shape_to_create.shape = shape
			shape_to_create.global_position = global_position
			
			var scene = get_tree().current_scene
			scene.add_child(shape_to_create)
			shape_to_create.owner = scene
			
			emit_signal("placed")
			queue_free()





