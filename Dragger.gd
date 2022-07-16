extends Node2D

var isDragging = false
var item = null
var clickedOffset : Vector2


func _process(delta):
	if item != null:
		var ratio = get_viewport().size.x/1920
		print(ratio)
		item.global_position = get_viewport().get_mouse_position()
		


func pickUpItem(_item, _clickedOffset):
	if item == null or (item is Card and _item.is_in_group("ClickPrio")):
		item = _item
		clickedOffset = _clickedOffset
	
func dropItem(_item):
	if item == _item:
		item.onDrop()
		item = null
		
	
	
	
	
