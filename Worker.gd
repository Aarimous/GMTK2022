extends Area2D
class_name Worker

var card = null
var currentHunger  = 4
var hungerMax = 4
var efficency = 1
export var workerName = "NAME"
var hoverCard = null
export var workingNoise : AudioStreamMP3
export var workingVolume  = 0
var isWorking = false

func _process(delta):
	
	global_position.x = clamp(global_position.x, 90, 1920 - 90)
	global_position.y = clamp(global_position.y, 120, 1080 -120)
	if isWorking:
		if $Working.playing == false:
			$Working.play()
	else:
		$Working.stop()

func show():
	visible = true
	$CollisionShape2D.disabled = false
	
func hide():
	visible = false
	$CollisionShape2D.disabled = true

func _ready():
	$Working.stop()
	$Working.stream = workingNoise
	$Working.volume_db = workingVolume
	$Name.text = workerName
	updateHunger()

func consumeHunger(amount):
	currentHunger = max(0, currentHunger - amount)
	updateHunger()
	
func addDice(dice):
	if dice.type == Game.RESOURCE_TYPE.FOOD:
		$Eating.play()
		consumeHunger(-dice.pips)
		dice.queue_free()
	
func updateHunger():
	$HBoxContainer/HungerValues.text = str(currentHunger, "/", hungerMax)
	if currentHunger == 0 :
		$Sprite.texture = load("res://Art/Char_Small.png")
		efficency = .5
	elif currentHunger > hungerMax:
		efficency = .5
		$Sprite.texture = load("res://Art/Char_Thick_Boi.png")
	elif currentHunger == hungerMax:
		efficency = 2
		$Sprite.texture = load("res://Art/Char_Med.png")
	elif currentHunger == 1:
		efficency = .75
		$Sprite.texture = load("res://Art/Char_Med.png")
	elif currentHunger == 3:
		efficency = 1.25
		$Sprite.texture = load("res://Art/Char_Med.png")
	else:
		efficency = 1
		$Sprite.texture = load("res://Art/Char_Med.png")
	
	$Efficency.text = str("Speed x", efficency)

		
func _on_Worker_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				$OnPickUp.play()
				$Working.stop()
				isWorking = false
				Dragger.pickUpItem(self, to_local(event.global_position))
				scale = Vector2.ONE
				if card != null:
					card.worker = null
				print("Player Clicked")
			else:
				Dragger.dropItem(self)		




func onDrop():
	if hoverCard != null:
		card = hoverCard
		hoverCard.addWorker(self)

		$OnPlaceInCard.play()
	else:
		if card != null:
			card.worker = null
		card = null
		$OnPlaceOnBoard.play()
		var gp = global_position
		get_parent().remove_child(self)
		Game.main.add_child(self)
		global_position = gp
		

func _on_Worker_area_entered(area):
	if area.is_in_group("Card"):
		hoverCard = area


func _on_Worker_area_exited(area):
	if area.is_in_group("Card") and area == hoverCard:
		hoverCard = null




