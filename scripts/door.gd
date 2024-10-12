extends InteractableStaticBody3D

var door_open: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	interactMessage = "Press E to open door"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(body: CharacterBody3D) -> void:
	$AnimationPlayer.active = true
	door_open = !door_open
	if door_open:
		$AnimationPlayer.play_backwards("rotation",1)
		interactMessage = "Press E to close door"
	else:
		$AnimationPlayer.play("rotation",-1,1,false)
		interactMessage = "Press E to open door"
		
