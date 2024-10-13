extends InteractableStaticBody3D

var open := false
@export var mesh : MeshInstance3D
@export var interactCollider : CollisionShape3D
@export var doorClosed : Vector3
@export var doorOpen : Vector3



func interact(_body):
	open = !open
	$Cabinet.play()
	
func _process(delta):
	if open and !(mesh.position == doorOpen):
		mesh.position = lerp(mesh.position, doorOpen, delta*20)
		interactCollider.position = mesh.position
	elif !open and !(mesh.position == doorClosed):
		mesh.position = lerp(mesh.position, doorClosed, delta*20)
		interactCollider.position = mesh.position
