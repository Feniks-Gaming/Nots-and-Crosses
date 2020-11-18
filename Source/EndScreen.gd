extends Control

onready var label = $MainText
const  main_game_scene_path = NodePathsHolder.Main_scene
onready var main_game_scene = preload(main_game_scene_path)
var winner = GameManager.current_round_winner
onready var is_draw: bool = GameManager.is_draw

func _ready() -> void:
	if not is_draw:
		winner = GameManager.current_round_winner
		label.text = "Winner of this round is: " + winner
	else: 
		label.text = "There is a draw"

func _on_Restart_pressed() -> void:
	get_tree().change_scene_to(main_game_scene)


func _on_Quit_pressed() -> void:
	get_tree().quit()
