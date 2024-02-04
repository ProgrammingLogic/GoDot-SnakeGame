extends CanvasLayer

var time_played = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func start():
	time_played = 0
	update_timer()
	update_score(0)


func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)
	
func update_timer():
	time_played += 1
	$TimerLabel.text = "Time: " + str(time_played)
