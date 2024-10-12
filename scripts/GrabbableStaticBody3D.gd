class_name GrabbableStaticBody3D
extends InteractableStaticBody3D

@export var mesh : MeshInstance3D
@export var collider : CollisionShape3D
@export var target : Node3D

func interact(body) -> void:
	if body.handsFull:
		body.dropItem(global_position)
	collider.disabled = true
	target = body.hand
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, 5 * delta)

func dropItem(pos : Vector3) -> void:
	global_position = pos
	collider.disabled = false
	target = null
