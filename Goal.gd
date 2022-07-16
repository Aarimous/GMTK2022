extends Area2D

func _ready():
	setGoals()
	pass

func setGoals():
	$CollisionShape2D.shape.extents = $PanelContainer.rect_size/2
	$CollisionShape2D.position = $PanelContainer.rect_position + $PanelContainer.rect_size/2

func addDice(dice):
	
	
	match dice.pips:
		1:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals1.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals1.addDice(dice)
				return
		2:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals2.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals2.addDice(dice)
				return
		3:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals3.anyOpenSlots(): 
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals3.addDice(dice)
				return
		4:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals4.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals4.addDice(dice)
				return
		5:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals5.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals5.addDice(dice)
				return
		6:
			if $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals6.anyOpenSlots():
				$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DiceGoals6.addDice(dice)
				return
	
	dice.rollInRandomDire(250, 135, 170, dice.global_position)
	
