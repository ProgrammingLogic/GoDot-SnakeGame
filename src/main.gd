extends Node2D


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



func _on_game_timer_timeout():	
	$HUD.update_timer()			
