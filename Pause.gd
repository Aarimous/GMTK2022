extends Control

	
	
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_Resume_button_up():
	visible = false
	get_tree().paused = false


func _on_Main_Menu_button_up():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")
