extends VBoxContainer


export var diceNum = 1
export var numNeeded = 2

func _ready():
	match diceNum:
		1:
			$CenterContainer/TextureRect.texture = load("res://Art/dieWhite1.png")
		2:
			$CenterContainer/TextureRect.texture = load("res://Art/dieWhite2.png")
		3:
			$CenterContainer/TextureRect.texture = load("res://Art/dieWhite3.png")
		4:
			$CenterContainer/TextureRect.texture  = load("res://Art/dieWhite4.png")
		5:
			$CenterContainer/TextureRect.texture = load("res://Art/dieWhite5.png")
		6:
			$CenterContainer/TextureRect.texture = load("res://Art/dieWhite6.png")
			
	createSlots(numNeeded)
	
func createSlots(num):
	for i in range(num):
		add_child(load("res://DiceSlot.tscn").instance().init(Game.RESOURCE_TYPE.MISC))	

func anyOpenSlots():
	for diceSlot in get_children():
		if diceSlot.is_in_group("DiceSlot") and diceSlot.isFree:
			return true
	return false	

func addDice(dice):
	for diceSlot in get_children():
		if diceSlot.is_in_group("DiceSlot") and diceSlot.isFree:
			diceSlot.addDice(dice)
			return
			
func setGoal(num):
	numNeeded = num
	for diceSlot in get_children():
		if diceSlot.is_in_group("DiceSlot"):
			if diceSlot.isFree == false:
				diceSlot.currentDice.queue_free()
			diceSlot.queue_free()	
	createSlots(numNeeded)
				
			

