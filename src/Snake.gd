extends Area2D

var speed = 0
var velocity = Vector2(0, 0)
var screen
var screen_size
var center_of_screen


# Called when the node enters the scene tree for the first time.
func _ready():
	screen = get_viewport_rect()
	screen_size = screen.get_area()
	center_of_screen = screen.get_center()
	
	hide()
	

func start():
	position = center_of_screen
	speed = 200
	show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_rotation
		
	if Input.is_action_pressed("turn_right"):
		new_rotation = 2 * PI
		velocity.x = speed * 1
		velocity.y = 0
	elif Input.is_action_pressed("turn_left"): 
		new_rotation = PI
		velocity.x = speed * -1
		velocity.y = 0
	elif Input.is_action_pressed("turn_up"):
		new_rotation = PI / 2
		velocity.x = 0
		velocity.y = speed * -1
	elif Input.is_action_pressed("turn_down"):
		new_rotation = (3 * PI) / 2
		velocity.x = 0
		velocity.y = speed * 1		


	# Move the snake
	position += velocity * delta
	
	if rotation != TYPE_NIL:
		rotation = new_rotation


func _on_visible_on_screen_notifier_2d_screen_exited():
	# If we are to the right of the screen
	if position.x > screen.size.x:
		position.x = 0
	# If we are to the left of the screen
	elif position.x < 0:
		position.x = screen.size.x
	
	# If we are below the screen 
	if position.y > screen.size.y:
		position.y = 0
	# If we are above the screen
	elif position.y < 0:
		position.y = screen.size.y
	
	
