# Interactable.gd
class_name InteractableStaticBody3D
extends StaticBody3D

@export var interactMessage := "Press E to Interact"

func _ready() -> void:
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	
# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	print("Base interact: ", body)
