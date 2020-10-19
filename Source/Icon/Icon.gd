extends Sprite

enum Shapes {CROSS, CIRCLE}
export(Shapes) var shape

onready var cross = preload("res://Assets/cross.png")
onready var circle = preload("res://Assets/Circle.png")

func _ready():
	scale = Vector2(0.75,0.75)
	if shape == Shapes.CROSS:
		self.texture = cross
	elif shape == Shapes.CIRCLE:
		self.texture = circle
