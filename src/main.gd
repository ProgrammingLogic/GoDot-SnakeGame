extends Node2D

@export var coin_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	$HUD.start()
	$Snake.start()
	$GameTimer.start()
	
	create_coin()
	

func _on_game_timer_timeout():	
	$HUD.update_timer()			


func _on_game_area_area_exited(area):
	if (area == $Snake):
		$Snake.move_to_other_side(get_game_area_size(), $GameArea.position)
		
		
func get_game_area_size():
	var game_area_shape = $GameArea/GameAreaCollisionBox.get_shape()
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
	
	
