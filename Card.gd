extends Node2D
class_name Card

export var timeToComplete = 1
var currentTimeAdded = 0
var type
var cardType
var worker = null
var diceTypeToCreateArray = []
var diceRolls = 0
var isMax
var incrementDice


func init(_cardType, _type, _diceTypeToCreateArray, _diceInputTypesArray, _duration, _numRolls,_isMax,_incrementDice, _name, _description):
	cardType = _cardType
	type = _type
	diceTypeToCreateArray = _diceTypeToCreateArray
	for _type in _diceInputTypesArray:
		$DiceSlotCont/MarginContainer/DiceSlots.add_child(load("res://DiceSlot.tscn").instance().init(_type))
	timeToComplete = _duration
	diceRolls = _numRolls
	isMax = _isMax
	incrementDice = _incrementDice
	$Title.text = _name
	name = _name
	$Text.text = _description
	
	$BaseDuration.text = str("Base " , timeToComplete, " Seconds")
	
	$ProgressBar.value = 0
	$ProgressBar.max_value = 100

		
	if $DiceSlotCont/MarginContainer/DiceSlots.get_child_count() == 0:
		$DiceSlotCont.visible = false
		$DiceSlotCollisionShape.disabled = true
		

	$ProgressBar.modulate = Game.getColorByResourceType(_type)
	$Sprite.modulate = Game.getColorByResourceType(_type)
	$WorkerZone.modulate = Game.getColorByResourceType(_type)
	$DiceSlotCont.self_modulate = Game.getColorByResourceType(_type)
	return self

#func _ready():
	#init(0, [0,0], "Chat", "Is poopy, hehe!")

	
func _process(delta):	
	$DiceSlotCollisionShape.shape.extents = $DiceSlotCont.rect_size/2
	$DiceSlotCollisionShape.position = $DiceSlotCont.rect_position + $DiceSlotCont.rect_size/2
	


	if shouldProcess():
		currentTimeAdded += delta * worker.efficency
		$ProgressBar.value = $ProgressBar.max_value * currentTimeAdded/timeToComplete
		if currentTimeAdded >= timeToComplete:
			print("We need to create a die")
			for i in range(diceTypeToCreateArray.size()):
				createDice(diceTypeToCreateArray[i], cardType, i)
			$ProgressBar.value = 0
			currentTimeAdded = 0
			reduceDicePips()
			worker.consumeHunger(1)

func createDice(diceType, cardType, index):
	var newDice = load("res://Dice.tscn").instance()
	Game.main.add_child(newDice)
	newDice.global_position = global_position
	var pips = null
	
	
	if incrementDice:
		var diceSlot =  $DiceSlotCont/MarginContainer/DiceSlots.get_child(index)
		var dice = diceSlot.currentDice
		if diceRolls == 0:
			pips = dice.pips + 1
		diceSlot.currentDice = null
		diceSlot.isFree = true
		dice.queue_free()
		
	newDice.startBeingADiceDamnIt(diceType, pips, isMax, diceRolls)
		
func reduceDicePips():
	if incrementDice == false:
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
		diceSlot.type == Game.RESOURCE_TYPE.MISC or dice.type == Game.RESOURCE_TYPE.MISC) ):
			diceSlot.addDice(dice)
			return
	dice.rollInRandomDire(250, 135, 195, global_position)
			
	


