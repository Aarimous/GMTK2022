extends Node2D
class_name Card

			

func _on_Card_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				Dragger.pickUpItem(self, to_local(event.global_position))
				print("Card Clicked")
			else:
				Dragger.dropItem(self)


func _on_Card_mouse_entered():
	pass # Replace with function body.


func _on_Card_mouse_exited():
	pass # Replace with function body.
	
func onDrop():
	pass
	
	
func addWorker(worker):
	worker.get_parent().remove_child(worker)
	$WorkerSlot.add_child(worker)
	worker.scale = Vector2(.66,.66)
	worker.position = Vector2.ZERO
