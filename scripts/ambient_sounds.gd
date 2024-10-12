extends Node3D

var left_gain_mod = 0
var right_gain_mod = 0

@onready var audio_pan = AudioServer.get_bus_effect(0,0)

var left_ear
var right_ear
var back_ear

var playing
var to_play

var check_length = 1.41

# Called when the node enters the scene tree for the first time.
func _ready():
	left_ear = $LeftEar
	right_ear = $RightEar
	back_ear = $BackEar
	left_ear.play()
	right_ear.play()
	back_ear.play()
	check_length = $LRayCast3D.target_position.length()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	left_ear.global_transform.origin = global_transform.origin + Vector3(-1,0,0.5)
	right_ear.global_transform.origin = global_transform.origin + Vector3(1,0,0.5)
	right_ear.global_transform.origin = global_transform.origin + Vector3(1,0,-1)
	
	left_gain_mod = 0
	if $LRayCast3D.is_colliding():
		left_gain_mod += check_length/2 - ($LRayCast3D.get_collision_point() - $LRayCast3D.global_transform.origin).length() / 2
	if $LRayCast3D2.is_colliding():
		left_gain_mod += check_length/2 - ($LRayCast3D2.get_collision_point() - $LRayCast3D2.global_transform.origin).length() / 2
	
	right_gain_mod = 0
	if $RRayCast3D.is_colliding():
		right_gain_mod += check_length/2 - ($RRayCast3D.get_collision_point() - $RRayCast3D.global_transform.origin).length() / 2
	if $RRayCast3D2.is_colliding():
		right_gain_mod += check_length/2 - ($RRayCast3D2.get_collision_point() - $RRayCast3D2.global_transform.origin).length() / 2
	
	audio_pan.pan = left_gain_mod/check_length - right_gain_mod/check_length
	print(left_gain_mod/check_length - right_gain_mod/check_length)
func change_ambience(audiostream:AudioStream):
	if audiostream != left_ear.stream:
		var old_left = left_ear
		var old_right = right_ear
		var old_back = back_ear
		left_ear = left_ear.duplicate()
		right_ear = right_ear.duplicate()
		back_ear = back_ear.duplicate()
		
		
		left_ear.stream = audiostream
		right_ear.stream = audiostream
		back_ear.stream = audiostream
		
		add_child(left_ear)
		add_child(right_ear)
		add_child(back_ear)
		
		left_ear.play()
		right_ear.play()
		back_ear.play()
		
		var temp = create_tween().set_parallel(true)
		
		temp.tween_property(left_ear, "volume_db", -20, 0)
		temp.tween_property(right_ear, "volume_db", -20, 0)
		temp.tween_property(back_ear, "volume_db", -20, 0)
		temp.chain().tween_property(left_ear, "volume_db", 0, 3)
		temp.set_parallel(true)
		temp.tween_property(right_ear, "volume_db", 0, 3)
		temp.tween_property(back_ear, "volume_db", 0, 3)
		temp.tween_property(old_left, "volume_db", -20, 3)
		temp.tween_property(old_right, "volume_db", -20, 3)
		temp.tween_property(old_back, "volume_db", -20, 3)
		temp.chain().tween_callback(old_left.queue_free)
		temp.tween_callback(old_right.queue_free)
		temp.tween_callback(old_back.queue_free)
