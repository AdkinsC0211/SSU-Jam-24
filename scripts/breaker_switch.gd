extends InteractableStaticBody3D


var light_toggle: bool = true
@export var controlled_lights: Node3D
var haunted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	interactMessage = "Press E to turn the light off"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func interact(_body: CharacterBody3D) -> void:
	light_toggle = !light_toggle
	$AnimationPlayer.active = true
	if controlled_lights.get_child_count() > 0:
		for light in controlled_lights.get_children():
			light.flip_state()
			
	if light_toggle != true:
		$AnimationPlayer.play("flip_switch",-1,1,false)
		interactMessage = "Press E to turn the lights on"
		
	else:
		$AnimationPlayer.play_backwards("flip_switch",-1)
		interactMessage = "Press E to turn the light off"
		haunted = false
		
func haunt():
	for light in controlled_lights.get_children():
			light.flip_state()
	haunted = true
	
	
