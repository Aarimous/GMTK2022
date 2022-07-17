extends Area2D
class_name Worker

var card = null
var currentHunger  = 2
var hungerMax = 4
var efficency = 1

func _ready():
	init("Aarimous")

func init(_name):
	_name = name
	$Name.text = name
	updateHunger()
	pass
	
func consumeHunger(amount):
	currentHunger = max(0, currentHunger - amount)
	updateHunger()
	
func addDice(dice):
	if dice.type == Game.RESOURCE_TYPE.FOOD:
		consumeHunger(-dice.pips)
		dice.queue_free()
	
func updateHunger():
	$HBoxContainer/HungerValues.text = str(currentHunger, "/", hungerMax)
	if currentHunger == 0 or currentHunger > hungerMax:
		efficency = .5
	elif currentHunger == hungerMax:
		efficency = 2
	elif currentHunger == 1:
		efficency = .75
	elif currentHunger == 3:
		efficency = 1.25
	else:
	 efficency = 1
	
	$Efficency.text = str("Efficacy x", efficency)

		
func _on_Worker_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				Dragger.pickUpItem(self, to_local(event.global_position))
				scale = Vector2.ONE
				if card:
					card.worker = null
				print("Player Clicked")
			else:
				Dragger.dropItem(self)		




func onDrop():
	if card != null:
		card.addWorker(self)
	else:
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
		

func _on_Worker_area_entered(area):
	if area is Card:
		card = area


func _on_Worker_area_exited(area):
	if area is Card and area == card:
		card = null




