extends Node2D
class_name Card

export var timeToComplete = 2
var currentTimeAdded = 0
onready var diceSlots = $DiceSlotCont/MarginContainer/DiceSlots
onready var diceSlosCont = $DiceSlotCont

var worker = null



func _ready():
	$ProgressBar.value = 0
	$ProgressBar.max_value = 100
	if diceSlots.get_child_count() == 0:
		diceSlosCont.visible = false
		$DiceSlotCollisionShape.disabled = true

	
func _process(delta):	
	$DiceSlotCollisionShape.shape.extents = $DiceSlotCont.rect_size/2
	$DiceSlotCollisionShape.position = $DiceSlotCont.rect_position + $DiceSlotCont.rect_size/2
	


	if shouldProcess():
		currentTimeAdded += delta
		$ProgressBar.value = $ProgressBar.max_value * currentTimeAdded/timeToComplete
		if currentTimeAdded >= timeToComplete:
			print("We need to create a die")
			var newDice = load("res://Dice.tscn").instance()
			Game.main.add_child(newDice)
			newDice.global_position = global_position
			newDice.startBeingADiceDamnIt()
			$ProgressBar.value = 0
			currentTimeAdded = 0
			reduceDicePips()
			
func reduceDicePips():
	for diceSlot in $DiceSlotCont/MarginContainer/DiceSlots.get_children():
		diceSlot.currentDice.reducePips(1)


func shouldProcess():
	if worker == null:
		return false
	for diceSlot in $DiceSlotCont/MarginContainer/DiceSlots.get_children(): 
		if diceSlot.isFree == true:
			return false
	return true
				
			
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
	for diceSlot in $DiceSlotCont/MarginContainer/DiceSlots.get_children():
		if ( diceSlot.is_in_group("DiceSlot") and 
		diceSlot.isFree == true and 
		(diceSlot.type == dice.type or 
		diceSlot.type == Game.RESOURCE_TYPE.MISC) ):
			diceSlot.addDice(dice)
			return
	dice.rollInRandomDire(250, 135, 195, global_position)
			
	
