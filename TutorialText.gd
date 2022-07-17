extends Label

export var timeToShow = 0
export var duration = 30

var timer = 0

func _ready():
	visible = false	

func _process(delta):
	timer += delta
	
	if visible == true:
		duration -= delta
	else:
		if timer >= timeToShow:
			visible = true
	if duration <= 0:
		queue_free()
		
