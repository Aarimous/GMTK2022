extends Node2D
class_name Card

export var timeToComplete = 1
var currentTimeAdded = 0

var worker = null



onready var dicePacked = load("res://Dice.tscn")

func _ready():
	$ProgressBar.value = 0
	$ProgressBar.max_value = 100	

	
func _process(delta):
	if worker != null:
		currentTimeAdded += delta
		$ProgressBar.value = $ProgressBar.max_value * currentTimeAdded/timeToComplete
		if currentTimeAdded >= timeToComplete:
			print("We need to create a die")
			var newDice = dicePacked.instance()
			Game.main.add_child(newDice)
			newDice.global_position = global_position
			newDice.startBeingADiceDamnIt()
			$ProgressBar.value = 0
			currentTimeAdded = 0
			
			
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
	
	
func addWorker(_worker):
	worker = _worker
	worker.get_parent().remove_child(worker)
	$WorkerSlot.add_child(worker)
	worker.scale = Vector2(.66,.66)
	worker.position = Vector2.ZERO
	
func addDice(dice):
	for diceSlot in $PanelContainer/MarginContainer/DiceSlots.get_children():
		if ( diceSlot is DiceSlot and 
		diceSlot.isFree == true and 
		(diceSlot.type == dice.type or 
		diceSlot.type == Game.RESOURCE_TYPE.MISC) ):
			diceSlot.addDice(dice)
			break
			
	
