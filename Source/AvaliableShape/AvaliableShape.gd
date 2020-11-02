class_name AvaliableShape
extends Icon

# Allows player to pick up a shape and deectivates other shape when one of the 
# two is activie in play. It changes colour when players uses a shape. 

var is_selectable: bool = false
var is_selected: bool = false
var is_active: bool = false
var is_colour_adjused = false

# Colours used to inform player what shape is is_active and inis_active. 
const COLOUR_GRAY := Color(0.219608, 0.219608, 0.219608)
const COLOUR_NORMAL := Color(1, 1, 1) 


func _process(delta) -> void:
	_toggle_selection()
	_adjust_modulate()


func _on_ShapePlacer_destroyed():
	# allows as to desselect shape 
	_deselect()


func _on_ShapePlacer_placed():
	# emited when shape is place in board changes new active player
	is_active = not is_active
	is_colour_adjused = false


func _on_Area2D_mouse_entered() -> void:
	is_selectable = true


func _on_Area2D_mouse_exited() -> void:
	is_selectable = false


func _toggle_selection() -> void:
	if is_active:
		_select()
	else:
		is_colour_adjused = true


func _select() -> void:
	# selectable is true when mouse is over the shape
	if is_selectable:
		if Input.is_action_just_pressed("mouse_left_click"):
			is_selectable = false
			is_selected = true
			is_colour_adjused = true
			create_shape_placer()


func _deselect() -> void:
	if is_selected:
		is_selected = false
		is_colour_adjused = false


func _adjust_modulate() -> void:
	if is_colour_adjused:
		modulate = COLOUR_GRAY
	else:
		modulate = COLOUR_NORMAL


func create_shape_placer() -> void:
	var shape_placer = ShapePlacer.new()
	shape_placer.shape = shape
	var scene = get_tree().current_scene
	scene.add_child(shape_placer)
	shape_placer.owner = scene
