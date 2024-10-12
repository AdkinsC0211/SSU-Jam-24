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
	pass
	
func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and window_open == false:
		timer.start()
	


func _on_break_open_delay_timeout():
	$window_piece_manager/WindowSection.rotate_y(deg_to_rad(90))
	$window_piece_manager/WindowSection2.rotate_y(deg_to_rad(-90))
	window_open = true
	$Area3D.queue_free()


func interact(_body: CharacterBody3D) -> void:
	var rotation_inverter = -1
	if window_open:
		rotation_inverter *= -1
	
	$window_piece_manager/WindowSection.rotate_y(deg_to_rad(-90 * rotation_inverter))
	$window_piece_manager/WindowSection2.rotate_y(deg_to_rad(90 * rotation_inverter))
	window_open = !window_open
	if window_open:
		self.interactMessage = "Press E to close window"
		$Blinds.interactMessage = "Window is open"
	else:
		self.interactMessage = "Press E to open window"
		$Blinds.interactMessage = "Press E to close blinds"
