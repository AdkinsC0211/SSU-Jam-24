extends Node3D
class_name toggle_light

var light_strength: int = 1
var toggle: bool = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if toggle and not $On.playing:
		if not $Buzz.playing:
			$Buzz.play_sound()

func flip_state():
	toggle = !toggle
	if toggle:
		$Light/light_source.visible = true
		$On.play()
		return
	$Light/light_source.visible = false
	$Buzz.stop()
	$Off.play()
	
	
	
