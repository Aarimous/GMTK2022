extends Node2D

var currentTimeAdded = 0
enum CARD_TYPES {GATHERING, HUNTING_SMALL_GAME, HUNTING_LARGE_GAME, RIVER_WATER, PRAY_RNG, DIRTY_WATER}

export(Game.RESOURCE_TYPE) var type = 0
export(CARD_TYPES) var cardType = 0
export (Array, Game.RESOURCE_TYPE) var diceTypeToCreateArray = []
export (Array, Game.RESOURCE_TYPE) var diceInputTypesArray = []
export var timeToComplete = 1
export var diceRolls = 0
export var isMax = false
export var incrimentInputDice = 0
export var consumeDice = false
export var title = "TITLE"
export var text = "Text"
export var minRoll = 1
export var maxRoll = 6
export var diceTheDice = false


var worker = null


#func init(_cardType, _type, _diceTypeToCreateArray, _diceInputTypesArray, _duration, _numRolls,_isMax,_incrementDice, _name, _description):
func _ready():

	for _type in diceInputTypesArray:
		$DiceSlotCont/MarginContainer/DiceSlots.add_child(load("res://DiceSlot.tscn").instance().init(_type))
		$DiceSlotCont.visible = true
		$DiceSlotCollisionShape.disabled = false
		
	$Title.text = title
	$Text.text = text
	$BaseDuration.text = str("Base " , timeToComplete, " Seconds")
	
	$ProgressBar.value = 0
	$ProgressBar.max_value = 100

	if $DiceSlotCont/MarginContainer/DiceSlots.get_child_count() == 0:
		$DiceSlotCont.visible = false
		$DiceSlotCollisionShape.disabled = true
	
	$DiceSlotCollisionShape.shape.extents = $DiceSlotCont.rect_size/2
	$DiceSlotCollisionShape.position = $DiceSlotCont.rect_position + $DiceSlotCont.rect_size/2

	$ProgressBar.modulate = Game.getColorByResourceType(type)
	$Sprite.modulate = Game.getColorByResourceType(type)
	$WorkerZone.modulate = Game.getColorByResourceType(type)
	$DiceSlotCont.self_modulate = Game.getColorByResourceType(type)

	
func show():
	visible = true
	$CollisionShape2D.disabled = false
	if $DiceSlotCont/MarginContainer/DiceSlots.get_child_count() == 0:
		$DiceSlotCont.visible = false
		$DiceSlotCollisionShape.disabled = true
	else:		
		$DiceSlotCont.visible = true
		$DiceSlotCollisionShape.disabled = false
		

func hide():
	visible = false
	$CollisionShape2D.disabled = true
	$DiceSlotCollisionShape.disabled = true

	
func _process(delta):
	global_position.x = clamp(global_position.x, 110, 1920 - 110)
	global_position.y = clamp(global_position.y, 190, 1080 -160)

	if shouldProcess():
		worker.isWorking = true
		currentTimeAdded += delta * worker.efficency
		$ProgressBar.value = $ProgressBar.max_value * currentTimeAdded/timeToComplete
		if currentTimeAdded >= timeToComplete:
			print("We need to create a die")
			var numDiceToCreate = diceTypeToCreateArray.size()
			if diceTheDice:
				var dice = $DiceSlotCont/MarginContainer/DiceSlots.get_child(0).currentDice
				for i in range(dice.pips):
					createDice(type, 0)
				$DiceSlotCont/MarginContainer/DiceSlots.get_child(0).currentDice = null
				$DiceSlotCont/MarginContainer/DiceSlots.get_child(0).isFree = true
				dice.queue_free()
			else:
				for i in range(numDiceToCreate):
					createDice(diceTypeToCreateArray[i], i)
			$ProgressBar.value = 0
			currentTimeAdded = 0
			reduceDicePips()
			worker.consumeHunger(1)
	else:
		if worker != null:
			worker.isWorking = false
			

func createDice(diceType, index):
	var newDice = load("res://Dice.tscn").instance()
	Game.main.add_child(newDice)
	newDice.global_position = global_position
	var pips = null
	
	if consumeDice:
		var diceSlot =  $DiceSlotCont/MarginContainer/DiceSlots.get_child(index)
		var dice = diceSlot.currentDice
		diceType = dice.type
		if incrimentInputDice != 0:
			pips = dice.pips + incrimentInputDice
		dice.queue_free()
		diceSlot.currentDice = null
		diceSlot.isFree = true
		
		
	newDice.startBeingADiceDamnIt(diceType, pips, isMax, diceRolls, minRoll, maxRoll)
		
func reduceDicePips():
	if consumeDice == false and diceTheDice == false:
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
				$OnPickUp.play()
				Dragger.pickUpItem(self, to_local(event.global_position))
				print("Card Clicked")
			else:
				Dragger.dropItem(self)


func _on_Card_mouse_entered():
	pass # Replace with function body.


func _on_Card_mouse_exited():
	pass # Replace with function body.
	
func onDrop():
	$OnDrop.play()
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
	$Wamp.play()
			
	


