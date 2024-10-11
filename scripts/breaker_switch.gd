extends InteractableStaticBody3D


var light_toggle: bool = true
var y_movement: float = -1.3
@export var controlled_lights: Array[toggle_light] = []


	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	interactMessage = "Press E to turn the light off"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func interact(_body: CharacterBody3D) -> void:
	light_toggle = !light_toggle
	$breaker_switch.translate(Vector3(0, y_movement, 0))
	y_movement *= -1
	
	for light in controlled_lights:
		light.flip_state()
		
	if light_toggle != true:
		interactMessage = "Press E to turn the lights on"
	else:
		interactMessage = "Press E to turn the light off"
	
