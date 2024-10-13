extends InteractableStaticBody3D

var player_ref
var camera_return_location: Vector3
var toggle: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		else:
			body.get_node("Neck").position += Vector3(0,2.3,0)
		


func _on_area_3d_body_exited(body):
	player_ref.get_node("Neck").position += Vector3(0,2.3,0)
