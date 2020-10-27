class_name AvaliableShape
extends Icon

var selectable: bool = false
var selected: bool = false
var active: bool = false
var colour_adjused = false

const COLOUR_GRAY := Color(0.219608, 0.219608, 0.219608)
const COLOUR_NORMAL := Color(1, 1, 1) 


func _process(delta) -> void:
	_toggle_selection()
	_adjust_modulate()


func _on_Area2D_mouse_entered() -> void:
	selectable = true


func _toggle_selection() -> void:
	if active:
		_select()
		_deselect()
	else:
		colour_adjused = true


func _select() -> void:
	if selectable:
		if Input.is_action_just_pressed("mouse_left_click"):
			selectable = false
			selected = true
			colour_adjused = true


func _deselect() -> void:
	if selected:
		if Input.is_action_just_pressed("mouse_right_click"):
			selected = false
			colour_adjused = false


func _adjust_modulate() -> void:
	if colour_adjused:
		modulate = COLOUR_GRAY
	else:
		modulate = COLOUR_NORMAL


func _on_Area2D_mouse_exited() -> void:
	selectable = false

