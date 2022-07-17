extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("GameOver",self, "_on_GameOver")


func _on_GameOver():
	visible = true
	get_tree().paused = true
	$Win.play()

func _on_Main_Menu_button_up():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")
