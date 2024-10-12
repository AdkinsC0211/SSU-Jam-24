extends InteractableStaticBody3D

@onready var window_delay_time = randf_range(0.3, 2.0)
@onready var timer = $break_open_delay

@export var spoopy_window: bool

#window_variables
var window_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = window_delay_time
	if spoopy_window == false:
		$Area3D.queue_free()
	$Blinds.interactMessage = "Press E to close blinds"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if window_open and $Wind.playing==false:
		$Wind.play()
	elif not window_open:
		if not $AnimationPlayer.is_playing():
			$Wind.stop()
	
func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and window_open == false:
		timer.start()
	


func _on_break_open_delay_timeout():
	$AnimationPlayer.play("open_window",-1,1,false)
	window_open = true
	$Area3D.queue_free()


func interact(_body: CharacterBody3D) -> void:
	$AnimationPlayer.active = true
	if !$Blinds.blinds_open:
		self.interactMessage = "Blinds are closed"
	else:
		if !window_open:
			$AnimationPlayer.play("open_window",-1,1,false)
			self.interactMessage = "Press E to close window"
			$Blinds.interactMessage = "Window is open"
		else:
			$AnimationPlayer.play_backwards("open_window",-1)
			self.interactMessage = "Press E to open window"
			$Blinds.interactMessage = "Press E to close blinds"
		window_open = !window_open
