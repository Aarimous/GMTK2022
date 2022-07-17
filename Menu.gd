extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_up():
	get_tree().change_scene("res://Main.tscn")


func _on_Twitch_button_up():
	OS.shell_open("http://www.twitch.tv/aarimous")


func _on_YouTube_button_up():
	OS.shell_open("http://www.youtube.com/aarimous")
