extends Control



var isFree = true
var currentDice = null
export(Game.RESOURCE_TYPE) var type

func init(_type):
	type = _type
	$Panel.modulate = Game.getColorByResourceType(type)
	$Label.text = Game.getTextByResourceType(type)
	return self

func _ready():
		$Panel.modulate = Game.getColorByResourceType(type)
		$Label.text = Game.getTextByResourceType(type)
		

func addDice(dice):
	dice.get_parent().remove_child(dice)
	add_child(dice)
	dice.position = Vector2.ZERO + Vector2(36,36)
	isFree = false
	currentDice = dice
	dice.slot = self
	

