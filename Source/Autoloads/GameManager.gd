extends Node

# Autoload class used to set up a board and control the players turn and active
# shape

const end_screen_path = NodePathsHolder.EndScreen_scene
var avaliable_shapes: Array = []
var current_round_winner: String = "aa"
var is_draw = false


func _on_avaliable_shapes_created() -> void:
	add_avaliable_shapes_to_array()
	activate_one_random_shape()


func add_avaliable_shapes_to_array() -> void:
	avaliable_shapes = get_tree().get_nodes_in_group("AvaliableShape")


func activate_one_random_shape()-> void:
	var shape_to_activate: AvaliableShape = Utility.choose(avaliable_shapes)
	shape_to_activate.is_active = true


func _on_Board_player_won(shape: String)-> void:
	is_draw = false
	current_round_winner = shape.capitalize()
	go_to_end_screen()

func _on_Board_game_is_draw():
	is_draw = true
	go_to_end_screen()


func go_to_end_screen() -> void:
	get_tree().change_scene_to(load(end_screen_path))
	
	
