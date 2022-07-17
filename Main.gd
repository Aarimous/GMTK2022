extends Node2D

func _ready():
	Game.main = self
	$UI/Pause.visible = false
	$UI/Win.visible = false
	get_tree().paused = false
	
	for child in get_children():
		if child.is_in_group("HideOnLoad"):
			child.hide()
	doTier0()
	
	
func doTier0():
#
#	$Dice.show()
#	$Dice2.show()
#	$Dice3.show()

	
	$Card_Gather_Fruit_Nuts.show()
	$Card_Dirty_Water.show()
	$Card_River_Water.show()
	$Worker1.show()

	#$Card_Twitch_Chat.show()
	#$Card_Witches_Brew.show()
	#$Card_Dice_the_Dice.show()
	#$Card_Really_Small_Rocks.show()
	#$Card_Lazy_Dev_Inc_1.show()
	#$Card_Lazy_Dev_Dec_2.show()
	
	
func doTier1():
	$Card_Pray_To_RNGesus.show()
	$Worker2.show()
	
func doTier2():
	$Card_Really_Small_Rocks.show()
	$Card_Dice_the_Dice.show()
	
	
func doTier3():
	$Card_Farm.show()
	$Card_Beaver_Damn.show()
	#$Card_Lazy_Dev_Inc_1.show()
	#$Card_Lazy_Dev_Dec_2.show()
	$Worker3.show()
	
func doTier4():
	$Card_Witches_Brew.show()
	$Card_Twitch_Chat.show()
	$Worker4.show()

	
	


