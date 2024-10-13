extends Node3D

var canPray = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$TaskList.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quest_log"):
		$TaskList.visible = !$TaskList.visible
