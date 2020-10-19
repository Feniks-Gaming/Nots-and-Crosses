extends "res://Source/Icon/Icon.gd"

var selectable: bool = false
var selected: bool = false
var active: bool = true

const COLOUR_GRAY = Color(0.219608, 0.219608, 0.219608)
const COLOUR_NORMAL = Color(1, 1, 1) 




func _process(delta):
	_toggle_selection()
	_adjust_modulate()


func _on_Area2D_mouse_entered():
	selectable = true


func _toggle_selection():
	_select()
	_deselect()


func _select():
	if selectable:
		if Input.is_action_just_pressed("mouse_left_click"):
			selectable = false
			selected = true


func _deselect():
	if selected:
		if Input.is_action_just_pressed("mouse_right_click"):
			selected = false


func _adjust_modulate():
	if selected:
		modulate = COLOUR_GRAY
	else:
		modulate = COLOUR_NORMAL


func _on_Area2D_mouse_exited():
	selectable = false

