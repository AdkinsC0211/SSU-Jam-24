wwwextends Node3D

@export var hours : int
@export var minutes : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$Timer.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Timer.start(1) #This is for time of day
	GameInfo.secondspassed += 1
	hours = int((GameInfo.secondspassed /60) % 12)
	minutes = int(GameInfo.secondspassed % 60)
	print("Time of day: ", hours, ":", minutes)
