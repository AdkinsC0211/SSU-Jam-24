# Interactable.gd
class_name InteractableStaticBody3D
extends StaticBody3D

@export var interactMessage := "Press E to open door"

var door_open: bool = false



# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	var invert_rotation = 1
	if door_open:
		invert_rotation *= -1
	self.global_rotate(Vector3(0,1,0),deg_to_rad(90 * invert_rotation))
	door_open = !door_open
	if !door_open:
		interactMessage = "Press E to open door"
	else:
		interactMessage = "Press E to close door"
