# Interactable.gd
class_name InteractableRigidBody3D
extends RigidBody3D

@export var interactMessage := "Press E to Interact"

# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	print("Base interact: ", body)
