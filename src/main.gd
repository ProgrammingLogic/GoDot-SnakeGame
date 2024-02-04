extends Node2D

@export var coin_scene: PackedScene

var score


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	score = 0
	
	$HUD.start()
	$Snake.start(get_game_area_size(), $GameArea.position)
	$GameTimer.start()
	
	create_coin()	
	

func _on_game_timer_timeout():	
	$HUD.update_timer()			
		
		
func get_game_area_size():
	var game_area_shape = $GameArea/CollisionShape2D.get_shape()
	var game_area_rect = game_area_shape.get_rect()
	return game_area_rect.size
		
		
func create_coin():
	var game_area_size = get_game_area_size()
	var coin = coin_scene.instantiate()
	
	var min_x = $GameArea.position.x
	var min_y = $GameArea.position.y
	var max_x = game_area_size.x
	var max_y = game_area_size.y	
	
	coin.position.x = randf_range(min_x, max_x)
	coin.position.y = randf_range(min_y, max_y)
	
	add_child(coin)
	
	
func _on_game_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == $Snake:	
		$Snake.outside_bounds.emit()


func _on_snake_collided(collision_info):
	var collider = collision_info.get_collider()
	
	if collider == $Coin:
		score += 1
		$HUD.update_score(score)
		remove_child(collider)
		create_coin()
