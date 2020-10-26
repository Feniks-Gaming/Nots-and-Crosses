extends Area2D

signal mouse_inside_area(name)

onready var board: Node2D = find_parent("Board")


func _ready() -> void:
	self.connect("mouse_entered",self,"_on_Segment_mouse_entered")
	self.connect("mouse_inside_area", board, "_on_Segment_mouse_inside")


func _on_Segment_mouse_entered() -> void:
	emit_signal("mouse_inside_area", self.name)
