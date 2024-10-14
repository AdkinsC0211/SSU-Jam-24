extends Node3D

@export var hours : int
@export var minutes : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TaskList/CanvasLayer.visible = false
	$Timer.start(1)



var canPray = false

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quest_log"):
		$TaskList/CanvasLayer.visible = !$TaskList/CanvasLayer.visible


func _on_timer_timeout() -> void:
	$Timer.start(1) #This is for time of day
	GameInfo.secondspassed += 1
	hours = int((GameInfo.secondspassed /60) % 12)
	minutes = int(GameInfo.secondspassed % 60)
