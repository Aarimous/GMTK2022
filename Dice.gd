extends Area2D
class_name Dice

var direction = Vector2(1,0)
var card = null
var type


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body
	
	
func onDrop():
	var tween = get_tree().create_tween() as SceneTreeTween
	tween.tween_property(self, "rotation", 0.0, .25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	if card != null:
		card.addDice(self)
	else:
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
	


func _on_Dice_area_entered(area):
	if area is Card:
			card = area


func _on_Dice_area_exited(area):
	if area is Card and area == card:
		card = null



func _on_Dice_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				Dragger.pickUpItem(self, to_local(event.global_position))
				print("Dice Clicked")
			else:
				Dragger.dropItem(self)
				
				
func startBeingADiceDamnIt():
	var diceRoll = Game.rng.randi_range(1,6)
	setDiceFace(diceRoll)
	
	var typeRoll = Game.rng.randi_range(0,2)
	type = typeRoll
	setDiceColorByType(typeRoll)
	
	
	var rot = Game.rng.randi_range(-15,30)
	direction = direction.rotated(deg2rad(rot))
	var distance = Game.rng.randi_range(200,400)
	var targetLocation = direction * distance
	
	var spinAmount = Game.rng.randi_range(-720, 720)
	
	var tween = get_tree().create_tween() as SceneTreeTween
	tween.set_parallel(true)
	tween.tween_property(self, "global_position:x", global_position.x + targetLocation.x, .5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position:y", global_position.y + targetLocation.y, .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", deg2rad(spinAmount), .5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


func setDiceFace(value):
	match value:
		1:
			$Sprite.texture = load("res://Art/dieWhite1.png")
		2:
			$Sprite.texture = load("res://Art/dieWhite2.png")
		3:
			$Sprite.texture = load("res://Art/dieWhite3.png")
		4:
			$Sprite.texture = load("res://Art/dieWhite4.png")
		5:
			$Sprite.texture = load("res://Art/dieWhite5.png")
		6:
			$Sprite.texture = load("res://Art/dieWhite6.png")
			
	
func setDiceColorByType(type):
	modulate = Game.getColorByResourceType(type)
	
	
	


