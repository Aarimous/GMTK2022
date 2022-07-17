extends Node2D

func _ready():
	var newDice = load("res://Dice.tscn").instance()
	add_child(newDice)
	newDice.startBeingADiceDamnIt(Game.RESOURCE_TYPE.WATER, 1, null, null)
	$UI/Pause.visible = false
	get_tree().paused = false
