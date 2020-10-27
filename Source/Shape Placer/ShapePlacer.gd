extends Icon
class_name ShapePlacer

signal destroyed

var avaliable_shapes: Array

func _ready():
	avaliable_shapes = GameManager.avaliable_shapes
	connect_to_shapes()


func _process(delta: float) -> void:
	follow_mouse()
	destroy()

func follow_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	position = mouse_pos


func destroy():
	if Input.is_action_just_pressed("mouse_right_click"):
		emit_signal("destroyed")
		queue_free()


func connect_to_shapes():
	for shape in avaliable_shapes:
		connect("destroyed", shape, "_on_ShapePlacer_destroyed")
