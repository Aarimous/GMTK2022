extends Node2D
class_name Worker

var card = null

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				Dragger.pickUpItem(self, to_local(event.global_position))
				scale = Vector2.ONE
				print("Player Clicked")
			else:
				Dragger.dropItem(self)
				


func _on_Area2D_mouse_entered():
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	pass # Replace with function body.


func onDrop():
	if card != null:
		card.addWorker(self)
	else:
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
	
func _on_Area2D_area_entered(area):
	if area is Card:
		card = area

		
func _on_Area2D_area_exited(area):
	if area is Card and area == card:
		card = null

