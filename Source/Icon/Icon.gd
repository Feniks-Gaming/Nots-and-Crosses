extends Area2D
class_name Icon

# Icon is a base class that allows us to asign the shape either a cross or a 
# circle to it's children. It alls oscales down shapes to fit a board. 

enum Shapes {CROSS, CIRCLE}
export(Shapes) var shape

onready var cross: Texture = preload("res://Assets/Cross.png")
onready var circle: Texture = preload("res://Assets/Circle.png")
onready var my_sprite: Sprite = $Sprite

func _ready() -> void:
	scale = Vector2(0.75,0.75)
	if shape == Shapes.CROSS:
		my_sprite.texture = cross
	elif shape == Shapes.CIRCLE:
		my_sprite.texture = circle
