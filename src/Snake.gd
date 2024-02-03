extends Node2D


var speed = Vector2(50, 50)

# Direction defaults to right
var direction = Vector2(1, 0) 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	# Set direction to right
	if Input.is_action_pressed("turn_right"): 
		direction.x = 1
		direction.y = 0
	# Set direction to left
	elif Input.is_action_pressed("turn_left"): 
		direction.x = -1
		direction.y = 0
	# Set direction to up
	elif Input.is_action_pressed("turn_up"):
		direction.x = 0
		direction.y = -1
	# Set direction to down
	elif Input.is_action_pressed("turn_down"):
		direction.x = 0
		direction.y = 1
		

	# Move the snake
	position += (direction * speed) * delta
