extends CharacterBody2D

var speed = 0
var screen
var screen_size
var center_of_screen
var game_area


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


func move_to_other_side(game_size, game_position):
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


#func _on_area_entered(area):
	#print("collision")
	#if area == game_area_scene:
		#print("collision with game area")
	#elif area == coin_scene:
		#print("collision with coin")


#func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#print("collision")
	#if area == game_area_scene:
		#print("collision with game area")
	#elif area == coin_scene:
		#print("collision with coin")


func _on_body_entered(body):
	print("collision")

