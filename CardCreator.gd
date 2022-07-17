extends Node
class_name CardCreator




var cardPacked = load("res://Card.tscn")

func init():
	print("Card Creator Init")


func getTier0Card():
	var rntArray = []
	rntArray.append(cardPacked.instance().init(CARD_TYPES.GATHERING, Game.RESOURCE_TYPE.FOOD, [Game.RESOURCE_TYPE.FOOD],[], 5,1,false,false, "Gather", "+1 Food Dice"))
	rntArray.append(cardPacked.instance().init(CARD_TYPES.RIVER_WATER, Game.RESOURCE_TYPE.WATER, [Game.RESOURCE_TYPE.WATER],[Game.RESOURCE_TYPE.WATER], 4,0,false,true,"River Water", "Add 1 Pip to an Input Dice"))
	rntArray.append(cardPacked.instance().init(CARD_TYPES.PRAY_RNG, Game.RESOURCE_TYPE.MISC, [Game.RESOURCE_TYPE.MISC],[Game.RESOURCE_TYPE.MISC], 6,1,false,true,"Pray to RNGesus", "Reroll the dice that was Input"))
	return rntArray


func getTier1Card():
	var rntArray = []
	rntArray.append(cardPacked.instance().init(CARD_TYPES.HUNTING_SMALL_GAME, Game.RESOURCE_TYPE.FOOD, [Game.RESOURCE_TYPE.FOOD],[], 8,2,false, false,"Hunt Small Game", "+1 Food Dice\n 2x Rolls keeping the SMALLEST"))
	rntArray.append(cardPacked.instance().init(CARD_TYPES.GATHERING, Game.RESOURCE_TYPE.FOOD, [Game.RESOURCE_TYPE.FOOD],[], 5,1,false,false,"Gather", "+1 Food Dice"))
	return rntArray


#func createCardByType(type):
#	var newCard = cardPacked.instance() as Card
#	match type:
#
#			return newCard.init(CARD_TYPES.HUNTING_SMALL_GAME, Game.RESOURCE_TYPE.FOOD, [Game.RESOURCE_TYPE.FOOD],[], 8,2,false,"Hunt Small Game", "+1 Food Dice\n 2x Rolls keeping the SMALLEST")
#		CARD_TYPES.HUNTING_LARGE_GAME:
#			return newCard.init(CARD_TYPES.HUNTING_SMALL_GAME, Game.RESOURCE_TYPE.FOOD, [Game.RESOURCE_TYPE.FOOD],[], 8,2,true,"Hunt Large Game", "+1 Food Dice\n 2x Rolls keeping the LARGEST")
