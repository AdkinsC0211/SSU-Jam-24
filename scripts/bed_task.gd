extends InteractableStaticBody3D

var player_ref
var camera_return_location: Vector3
var toggle: bool = false
var neck_moved = false
var haunted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ghost_light.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(body: CharacterBody3D) -> void:
	toggle = !toggle
	if body.is_in_group("Player"):
		player_ref = body
		camera_return_location = body.get_node("Neck").position
		if toggle:
			body.get_node("Neck").position += Vector3(0,-2.3,0)
			neck_moved = true
			$ghost_light.visible = false
			haunted = false
		else:
			body.get_node("Neck").position += Vector3(0,2.3,0)
			neck_moved = false
		
func haunt():
	$ghost_light.visible = true
	haunted = false

func _on_area_3d_body_exited(body):
	if neck_moved and body.is_in_group("Player"):
		body.get_node("Neck").position += Vector3(0,2.3,0)
	
