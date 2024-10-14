extends RayCast3D

var canInteract := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.has_method("interact") and not collider is GrabbableStaticBody3D and canInteract:
			collider.interact(self)
			$Timer.start(5)
			canInteract = false


func _on_timer_timeout() -> void:
	canInteract = true
