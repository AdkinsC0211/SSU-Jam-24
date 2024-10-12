extends InteractableStaticBody3D

var door_open: bool = false
var door_locked: bool = false
var first_hit = true


# Called when the node enters the scene tree for the first time.
func _ready():
	interactMessage = "Press E to open door"
	$AnimationPlayer.active = true
	#$AnimationPlayer.play("rotation")
	$AnimationPlayer.play_backwards("rotation")
	door_open = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(_body: CharacterBody3D) -> void:
	$AnimationPlayer.active = true
	if first_hit:
		first_hit = false
		interactMessage = "Press E to close door"
	
	if door_open:
		#$AnimationPlayer.play_backwards("rotation",-1)
		$AnimationPlayer.play("rotation",-1,1,false)
		
	elif !door_open and !door_locked:
		#$AnimationPlayer.play("rotation",-1,1,false)
		$AnimationPlayer.play_backwards("rotation",-1)
		
	elif door_locked and door_open:
		$AnimationPlayer.play_backwards("rotation",1)
	else:
		interactMessage = "Door is locked"
		return
		
	door_open = !door_open
	if door_open:
		interactMessage = "Press E to close door"
	elif !door_open and !door_locked:
		interactMessage = "Press E to open door"
	else:
		interactMessage = "Door is locked"
		
