extends Area2D
class_name Dice


var dropObject = null
export var type  = 0
export var isTest = false
var slot = null
var pips = null
var direction : Vector2


func _ready():
	if isTest: 
		startBeingADiceDamnIt(type, 3, false,0, 1,6)



func show():
	visible = true
	$CollisionShape2D.disabled = false
	
func hide():
	visible = false
	$CollisionShape2D.disabled = true


func _process(delta):
	global_position.x = clamp(global_position.x, 32, 1920 - 32)
	global_position.y = clamp(global_position.y, 32, 1080 -32)
	
	
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
	$OnDropNoCard.play()
	if dropObject != null:
		print("Adding Dice to Area ", dropObject.name)
		dropObject.addDice(self)
	else:
		
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
	


func _on_Dice_area_entered(area):
	if area is Worker and type == Game.RESOURCE_TYPE.FOOD:
		dropObject = area
	elif area.is_in_group("DiceDrop"):
		dropObject = area
	


func _on_Dice_area_exited(area):
	if (area.is_in_group("DiceDrop") or area is Worker) and area == dropObject:
		dropObject = null



func _on_Dice_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				$OnPickUp.play()
				Dragger.pickUpItem(self, to_local(event.global_position) )
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
				
				
func startBeingADiceDamnIt(_type, _pips, isMax, _numOfRolls = 0, minRoll = 1, maxRoll = 6):
	$OnCreate.play()
	if _pips != null:
		pips = clamp(_pips, 1 , 6)
	else:
		if _numOfRolls > 0:
			for i in range(_numOfRolls):
				var roll = Game.rng.randi_range(minRoll,maxRoll)
				print("Dice Roll ", i , " : ", roll)
				if pips == null or (isMax and roll > pips) or (isMax == false and roll < pips):
					pips = roll
					
	setDiceFace(pips)
	if _type == Game.RESOURCE_TYPE.MISC:
		type = Game.rng.randi_range(0,Game.RESOURCE_TYPE.keys().size() -1)
	else:
		type = _type
	
	setDiceColorByType(type)
	
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
	
	
func rollInRandomDire(dist, minAngle, maxAngle, startPos, dir = null):
	if dir == null:
		direction = Vector2(1,0)
		var rot = Game.rng.randi_range(minAngle,maxAngle)
		direction = direction.rotated(deg2rad(rot))
	else:
		direction = dir
	var distance = Game.rng.randi_range(dist, dist * 2)
	var targetLocation = direction * distance
	
	var spinAmount = Game.rng.randi_range(-720, 720)
	
	var tween = get_tree().create_tween() as SceneTreeTween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	tween.tween_property(self, "global_position:x", startPos.x + targetLocation.x, .5).set_trans(Tween.TRANS_QUINT).from(startPos.x)
	tween.tween_property(self, "global_position:y", startPos.y + targetLocation.y, .5).set_trans(Tween.TRANS_BOUNCE).from(startPos.y)
	tween.tween_property(self, "rotation", deg2rad(spinAmount), .5).set_trans(Tween.TRANS_QUINT)

	
	
	


