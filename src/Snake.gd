extends CharacterBody2D

var speed = 0
var screen
var screen_size
var center_of_screen
var game_area

var game_size
var game_position
signal outside_bounds
signal collided

# Called when the node enters the scene tree for the first time.
func _ready():
	screen = get_viewport_rect()
	screen_size = screen.get_area()
	center_of_screen = screen.get_center()
	
	hide()
	

func start(new_game_size, new_game_position):
	game_size = new_game_size
	game_position = new_game_position
	
	position = center_of_screen
	speed = 200
	show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the velocity based on user input
	if Input.is_action_pressed("turn_right"):
		velocity.x = speed * 1
		velocity.y = 0
	elif Input.is_action_pressed("turn_left"): 
		velocity.x = speed * -1
		velocity.y = 0
	elif Input.is_action_pressed("turn_up"):
		velocity.x = 0
		velocity.y = speed * -1
	elif Input.is_action_pressed("turn_down"):
		velocity.x = 0
		velocity.y = speed * 1		
	
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	
	if not collision_info:
		return
	
	collided.emit(collision_info)


func move_to_other_side():
	# If we are to the right of the game_area
	if position.x > game_size.x:
		position.x = game_position.x
	# If we are to the left of the game_area
	elif position.x < game_position.x:
		position.x = game_position.x + game_size.x
	
	# If we are below the game_area 
	if position.y > game_size.y:
		position.y = game_position.y
	# If we are above the game_area
	elif position.y < game_position.y:
		position.y = game_position.y + game_size.y


func _on_outside_bounds():
	move_to_other_side()
