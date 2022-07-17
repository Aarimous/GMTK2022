extends Node


var main
var rng : RandomNumberGenerator

signal GameOver


enum RESOURCE_TYPE {FOOD, WATER, MATERIAL, MISC}

var FOOD_COLOR : Color = Color('#C28D75')
var WATER_COLOR : Color = Color('#7CA1C0')
var MATERIAL_COLOR : Color = Color('#9A9A97')
var MISC_COLOR : Color = Color('#7E9E99')

var currentTier = 0

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()

	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_MOUSE_EXIT:
			if Dragger.item != null:
				Dragger.dropItem(Dragger.item)
		MainLoop.NOTIFICATION_WM_MOUSE_ENTER:
			print("Mouse has entered the game window")
	
	
func getColorByResourceType(type):
	match type:
		RESOURCE_TYPE.FOOD:
			return FOOD_COLOR
		RESOURCE_TYPE.WATER:
			return WATER_COLOR
		RESOURCE_TYPE.MATERIAL:
			return MATERIAL_COLOR
		RESOURCE_TYPE.MISC:
			return MISC_COLOR
	return Color.magenta
	
func getTextByResourceType(type):
	match type:
		RESOURCE_TYPE.FOOD:
			return "Food"
		RESOURCE_TYPE.WATER:
			return "Water"
		RESOURCE_TYPE.MATERIAL:
			return "Material"
		RESOURCE_TYPE.MISC:
			return "?"
	return "IDIOT"
	
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
