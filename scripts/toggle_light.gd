extends Node3D
class_name toggle_light

var light_strength: int = 1
var toggle: bool = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func flip_state():
	toggle = !toggle
	if toggle:
		$lampshade/light_source.light_energy = light_strength
		return
	$lampshade/light_source.light_energy = 0
	
	
	
