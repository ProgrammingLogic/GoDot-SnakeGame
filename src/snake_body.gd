extends CharacterBody2D

var speed
var right_velocity
var left_velocity
var down_velocity
var up_velocity

var snake_neighbor

var game_size
var game_position

signal outside_bounds


func set_snake_neighbor(neighbor):
	snake_neighbor = neighbor


func start(new_game_size, new_game_position):
	game_size = new_game_size
	game_position = new_game_position


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


func change_direction(direction):
	if direction == "right" and velocity != left_velocity:
		velocity = right_velocity
	elif direction == "left" and velocity != right_velocity:
		velocity = left_velocity
	elif direction == "up" and velocity != down_velocity:
		velocity = up_velocity
	elif direction == "down" and velocity != up_velocity:
		velocity = down_velocity


func get_size():
	return $CollisionShape2D.shape.get_rect().size
	
	
func update_velocity():
	print("changing direction")
	print(("neighbor velocity: %v" % snake_neighbor.velocity))
	
	var direction = "none"
	
	# Determine which direction the previous snake body is
	# If the previous snake body is to the RIGHT of this one, change the direction to "right"
	if snake_neighbor.velocity == right_velocity:
		direction = "right"
	# If the previous snake body is to the LEFT of this one, change the direction to "left"
	elif snake_neighbor.velocity == left_velocity:
		direction = "left"
	# If the previous snake body is ABOVE this one, change direction to "up"
	elif snake_neighbor.velocity == up_velocity:
		direction = "up"
	# If the previous snake body is BELOW this one, change the direction to "down"
	elif snake_neighbor.velocity == down_velocity:
		direction = "down"
		
	# check if adding the new velocity will put out bounds AFTER the new box
	
	change_direction(direction)
	

func _physics_process(delta):
	# Is this snake body going the same direction as the previous? If so, don't 
	# bother calculating collisons. 
	if velocity != snake_neighbor.velocity:
		update_velocity()
	

	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		print("snake_body has collided")
	

func _on_outside_bounds():
	print("snake body out of bounds")
	move_to_other_side()
