extends InteractableStaticBody3D

var open := false
@export var mesh : MeshInstance3D
@export var interactCollider : CollisionShape3D
@export var doorClosed : Vector3
@export var doorOpen : Vector3



func interact(body):
	open = !open
	
func _process(delta):
	if open and !(mesh.position == doorOpen):
		mesh.position = lerp(mesh.position, doorOpen, 0.01)
		interactCollider.position = mesh.position
	elif !open and !(mesh.position == doorClosed):
		mesh.position = lerp(mesh.position, doorClosed, 0.03)
		interactCollider.position = mesh.position
