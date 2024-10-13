extends InteractableStaticBody3D


var locked = false
@export var parent: InteractableStaticBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func interact(body: CharacterBody3D) -> void:
	if locked:
		locked = false
		$handle.rotate_z(deg_to_rad(90))
		interactMessage = "Press E to lock the door"
		handle_messages()
	else:
		locked = true
		$handle.rotate_z(deg_to_rad(-90))
		interactMessage = "Press E to unlock the door"
		handle_messages()
		
func handle_messages():
	if parent.open:
		if self.locked:
			parent.interactMessage = "Press E to close door"
		else:
			parent.interactMessage = "Press E to close door"
	else:
		if self.locked:
			parent.interactMessage = "Door is locked"
		else:
			parent.interactMessage = "Press E to open door"
		
