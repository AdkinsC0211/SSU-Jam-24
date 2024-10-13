extends InteractableStaticBody3D

var door_open: bool = true
var door_locked: bool = false
var first_hit = true
var shut = false


# Called when the node enters the scene tree for the first time.
func _ready():
	interactMessage = "Press E to open door"
	$AnimationPlayer.active = true
	#$AnimationPlayer.play("rotation")
	$AnimationPlayer.play_backwards("rotation")
	door_open = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if door_open and not $Move.playing and not shut:
		$Close.play()
		shut = true

func interact(_body: CharacterBody3D) -> void:
	$AnimationPlayer.active = true
	if first_hit:
		first_hit = false
		interactMessage = "Press E to close door"
	$Move.pitch_scale = randf_range(0.7, 1.2)
	if door_open:
		#$AnimationPlayer.play_backwards("rotation",-1)
		$AnimationPlayer.play("rotation",-1,1,false)
		$Move.play_sound()
		
	elif !door_open and !door_locked:
		#$AnimationPlayer.play("rotation",-1,1,false)
		$AnimationPlayer.play_backwards("rotation",-1)
		$Move.play_sound()
		
	elif door_locked and door_open:
		$AnimationPlayer.play_backwards("rotation",1)
		$Move.play_sound()
	else:
		interactMessage = "Door is locked"
		return
		
	door_open = !door_open
	if door_open:
		interactMessage = "Press E to close door"
		shut = false
	elif !door_open and !door_locked:
		interactMessage = "Press E to open door"
	else:
		interactMessage = "Door is locked"
		
