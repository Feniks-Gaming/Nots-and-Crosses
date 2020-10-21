extends Node2D

signal avaliable_shapes_created

func _ready():
	connect("avaliable_shapes_created",GameManager,"_on_avaliable_shapes_created")
	emit_signal("avaliable_shapes_created")
	
