extends InteractableStaticBody3D

@export var locked : bool = false

func _ready() -> void:
	interactMessage = "Press E to Lock"

func interact(body) -> void:
	locked = true
	interactMessage = "This Door is already Locked"
