extends Area2D

func _ready():
	setGoals()
	pass

func _process(delta):
	$CollisionShape2D.shape.extents = $PanelContainer.rect_size/2
	$CollisionShape2D.position = $PanelContainer.rect_position + $PanelContainer.rect_size/2

func setGoals():

	match Game.currentTier:
		0:	
			setValues(1,1,0,0,0,0)
			$PanelContainer/MarginContainer/VBoxContainer/Goal.text = "Tier 0 Goal - Tutorial"
#			for card in Game.cardCreator.getTier0Card():
#				Game.main.call_deferred("add_child", card)
		1:	
			setValues(3,2,1,0,0,0)
#			for card in Game.cardCreator.getTier1Card():
#				Game.main.call_deferred("add_child", card)
			Game.main.doTier1()
			$PanelContainer/MarginContainer/VBoxContainer/Goal.text = "Tier 1 Goal"
			
		2:
			setValues(4,3,1,1,0,0)
			Game.main.doTier2()
			$PanelContainer/MarginContainer/VBoxContainer/Goal.text = "Tier 2 Goal"
		3:
			setValues(3,3,1,1,1,0)
			$PanelContainer/MarginContainer/VBoxContainer/Goal.text = "Tier 3 Goal"
			Game.main.doTier3()
		4:
			setValues(6,4,4,2,2,2)
			$PanelContainer/MarginContainer/VBoxContainer/Goal.text = "Tier 4 Goal"
			Game.main.doTier4()

	
func addDice(dice):
	var throwUpDice = true
	
	match dice.pips:
		1:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals1.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals1.addDice(dice)
				throwUpDice = false
		2:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals2.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals2.addDice(dice)
				throwUpDice = false
		3:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals3.anyOpenSlots(): 
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals3.addDice(dice)
				throwUpDice = false
		4:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals4.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals4.addDice(dice)
				throwUpDice = false
		5:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals5.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals5.addDice(dice)
				throwUpDice = false
		6:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals6.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals6.addDice(dice)
				throwUpDice = false
	if throwUpDice:
		dice.rollInRandomDire(250, 135, 170, dice.global_position)
		$Wamp.play()
	else:
		$OnDiceAdded.play()
		
	for slot in $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer.get_children():
		if slot.anyOpenSlots():
			return
	
	Game.currentTier += 1
	$OnTeirUp.play()
	setGoals()
	if Game.currentTier > 4:
		Game.emit_signal("GameOver")
		
	
func setValues(d1, d2, d3, d4, d5, d6):
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals1.setGoal(d1)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals2.setGoal(d2)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals3.setGoal(d3)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals4.setGoal(d4)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals5.setGoal(d5)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals6.setGoal(d6)
	
