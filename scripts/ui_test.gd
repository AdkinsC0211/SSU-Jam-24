extends Node3D

@onready var pauseMenu = $pauseMenuRoot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Z"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pauseMenu.visible = true
		get_tree().paused = true
		
		
