extends InteractableStaticBody3D

var door_locked: bool = false
@onready var parent = self.get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(_body: CharacterBody3D) -> void:
	$lock_animation_player.active = true
	if door_locked:
		$lock_animation_player.play_backwards("lock_door",-1)
		interactMessage = "Press E to lock the door"
		if parent.door_open:
			parent.interactMessage = "Press E to close door"
		else:
			parent.interactMessage = "Press E to open door"
		
	else:
		$lock_animation_player.play("lock_door",-1)
		interactMessage = "Press E to unlock the door"
		if !parent.door_open:
			parent.interactMessage = "Door is locked"
			
	door_locked = !door_locked
	$Lock.pitch_scale = randf_range(0.7, 1.2)
	$Lock.play_sound()
	parent.door_locked = door_locked
	if !parent.door_open and !door_locked:
		interactMessage = "Press E to open door"
	
