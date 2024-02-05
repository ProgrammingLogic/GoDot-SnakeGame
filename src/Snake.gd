extends CharacterBody2D

@export var snake_body_scene: PackedScene

var speed = 0

var right_velocity
var left_velocity
var down_velocity
var up_velocity

var right_bounds
var left_bounds
var upper_bounds
var lower_bounds

var screen
var screen_size
var center_of_screen

var game_area
var game_size
var game_position

var body_parts = []

signal hit_self
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
	speed = 500
	
	right_velocity = Vector2(speed, 0)
	left_velocity = Vector2(speed * -1, 0)
	down_velocity = Vector2(0, speed)
	up_velocity = Vector2(0, speed * -1)
	
	body_parts = [self]
	show()
	
	
func get_size():
	return $CollisionShape2D.shape.get_rect().size


func change_direction(direction):
	if direction == "right" and velocity != left_velocity:
		velocity = right_velocity
	elif direction == "left" and velocity != right_velocity:
		velocity = left_velocity
	elif direction == "up" and velocity != down_velocity:
		velocity = up_velocity
	elif direction == "down" and velocity != up_velocity:
		velocity = down_velocity
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the velocity based on user input
	if Input.is_action_pressed("turn_right"):
		change_direction("right")
	elif Input.is_action_pressed("turn_left"): 
		change_direction("left")
	elif Input.is_action_pressed("turn_up"):
		change_direction("up")
	elif Input.is_action_pressed("turn_down"):
		change_direction("down")
	
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	
	if not collision_info:
		return
		
	var collider = collision_info.get_collider()
	
	if collider == left_bounds:
		print("left out of bounds")
	elif collider == right_bounds:
		print("right out of bounds")
	elif collider == lower_bounds:
		print("bottom out of bounds")
	elif collider == upper_bounds:
		print("up out of bounds")
	elif collider == snake_body_scene:
		hit_self.emit()
		
	
		
	
		
	
	print("snake has collided")
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
		
		
func grow():
	var snake_body = snake_body_scene.instantiate()
	var neighbor = body_parts[-1]
	snake_body.set_snake_neighbor(neighbor)
	snake_body.speed = neighbor.speed
	snake_body.left_velocity = left_velocity
	snake_body.right_velocity = right_velocity
	snake_body.up_velocity = up_velocity
	snake_body.down_velocity = down_velocity
	snake_body.start(game_size, game_position)
	
	
	# Calculate the body part's position
	var new_position = Vector2(neighbor.position.x, neighbor.position.y)
	
	if neighbor.velocity.x > 0: # Moving right 
		new_position.x = neighbor.position.x - neighbor.get_size().x
	elif neighbor.velocity.x < 0: # Moving left
		new_position.x = neighbor.position.x + neighbor.get_size().x
	elif neighbor.velocity.y > 0: # Moving down
		new_position.y = neighbor.position.y - neighbor.get_size().y
	elif neighbor.velocity.y < 0: # Moving up
		new_position.y = neighbor.position.y + neighbor.get_size().y


	snake_body.position = new_position
	snake_body.velocity = neighbor.velocity
	
	add_sibling(snake_body)
	body_parts.append(snake_body)
	


