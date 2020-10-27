extends Node

var avaliable_shapes: Array = []


func _on_avaliable_shapes_created() -> void:
	add_avaliable_shapes_to_array()
	activate_one_random_shape()


func add_avaliable_shapes_to_array() -> void:
	avaliable_shapes = get_tree().get_nodes_in_group("AvaliableShape")


func activate_one_random_shape()-> void:
	var shape_to_activate: AvaliableShape = Utility.choose(avaliable_shapes)
	shape_to_activate.active = true


