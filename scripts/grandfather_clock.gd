extends StaticBody3D

var confessionalHaunted := false
@export var confessional : Node3D
var targetDeg := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer3D.play_sound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hours = int((GameInfo.secondspassed / 60) + 8 % 12)
	var minutes = int(GameInfo.secondspassed % 60)
	
	if hours == 3 and not confessionalHaunted:
		confessionalHaunted = true
		if confessional:
			confessional.haunt()
	
	$GrandfatherClock/hour_hand.rotation_degrees.x = (-360 * hours/12) + (-360 * minutes/(60*12))
	$GrandfatherClock/minute_hand.rotation_degrees.x = -360 * minutes/60

	if GameInfo.secondspassed % 2:
		targetDeg = 10
	else:
		targetDeg = -10
		
	$GrandfatherClock/pedulum.rotation_degrees.x = lerp($GrandfatherClock/pedulum.rotation_degrees.x, targetDeg, 1*delta)
