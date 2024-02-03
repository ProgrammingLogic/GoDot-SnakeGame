extends Area2D

var speed = 1
var velocity = Vector2(0, 0)
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().get_center()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	# Set direction to right
	if Input.is_action_pressed("turn_right"):
		velocity.x = speed * 1
		velocity.y = 0
	# Set direction to left
	elif Input.is_action_pressed("turn_left"): 
		velocity.x = speed * -1
		velocity.y = 0
	# Set direction to up
	elif Input.is_action_pressed("turn_up"):
		velocity.x = 0
		velocity.y = speed * -1
	# Set direction to down
	elif Input.is_action_pressed("turn_down"):
		velocity.x = 0
		velocity.y = speed * 1		

	# Move the snake
	position += velocity
