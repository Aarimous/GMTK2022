extends Area2D
class_name Dice


var dropObject = null
var type
var slot = null
var pips = 0

export var isTest = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if isTest:
		startBeingADiceDamnIt()
	
	
func reducePips(value):
	pips -= value
	if pips <= 0:
		if slot != null:
			slot.currentDice = null
			slot.isFree = true
			queue_free()
	else:
		setDiceFace(pips)


func onDrop():
	var tween = get_tree().create_tween() as SceneTreeTween
	tween.tween_property(self, "rotation", 0.0, .25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

	if dropObject != null:
		dropObject.addDice(self)
	else:
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
	


func _on_Dice_area_entered(area):
	if area.is_in_group("DiceDrop"):
			dropObject = area


func _on_Dice_area_exited(area):
	if area.is_in_group("DiceDrop") and area == dropObject:
		dropObject = null



func _on_Dice_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				Dragger.pickUpItem(self, to_local(event.global_position))
				if slot != null:
					slot.currentDice = null
					slot.isFree = true
					slot = null
					var gp = global_position
					get_parent().remove_child(self)
					Game.main.add_child(self)
					global_position = gp
				print("Dice Clicked")
			else:
				Dragger.dropItem(self)
				
				
func startBeingADiceDamnIt():
	var diceRoll = Game.rng.randi_range(1,6)
	pips = diceRoll
	setDiceFace(diceRoll)
	
	var typeRoll = Game.rng.randi_range(0,2)
	type = typeRoll
	setDiceColorByType(typeRoll)
	
	rollInRandomDire(200, -15, 45, global_position)


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
	
	
func rollInRandomDire(dist, minAngle, maxAngle, startPos):
	var direction = Vector2(1,0)
	var rot = Game.rng.randi_range(minAngle,maxAngle)
	direction = direction.rotated(deg2rad(rot))
	var distance = Game.rng.randi_range(dist, dist * 2)
	var targetLocation = direction * distance
	
	var spinAmount = Game.rng.randi_range(-720, 720)
	
	var tween = get_tree().create_tween() as SceneTreeTween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	tween.tween_property(self, "global_position:x", startPos.x + targetLocation.x, .5).set_trans(Tween.TRANS_QUINT).from(startPos.x)
	tween.tween_property(self, "global_position:y", startPos.y + targetLocation.y, .5).set_trans(Tween.TRANS_BOUNCE).from(startPos.y)
	tween.tween_property(self, "rotation", deg2rad(spinAmount), .5).set_trans(Tween.TRANS_QUINT)

	
	
	


