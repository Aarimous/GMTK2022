extends Node2D

var isDragging = false
var item = null
var clickedOffset : Vector2


func _process(delta):
	if item != null:
		item.global_position = get_global_mouse_position() - clickedOffset


func pickUpItem(_item, _clickedOffset):
	if item == null or(item is Card and _item is Worker):
		item = _item
		clickedOffset = _clickedOffset
	
func dropItem(_item):
	if item == _item:
		item.onDrop()
		item = null
		
	
	
	
	
