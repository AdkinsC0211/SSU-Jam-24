# Interactable.gd
class_name InteractableCharacterBody3D
extends CharacterBody3D

@export var interactMessage := "Press E to Interact"

# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	print("Base interact: ", body)
