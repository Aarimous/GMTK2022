extends Control

	
	
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused
