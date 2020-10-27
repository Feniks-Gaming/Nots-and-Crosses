extends Icon

func _process(delta: float) -> void:
	follow_mouse()

func follow_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	position = mouse_pos
