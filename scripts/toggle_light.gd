extends Node3D
class_name toggle_light

var light_strength: int = 1
var toggle: bool = true
var spooky = false
var preSpookedToggle := true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spookify():
	if not spooky:
		spooky = true
		preSpookedToggle = toggle
		$flickerTimer.start(0.25)
		
func unspookify():
	spooky = false
	if not toggle == preSpookedToggle:
		flip_state()
	
	$flickerTimer.stop()

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
	

func _on_flicker_timer_timeout() -> void:
	flip_state()
