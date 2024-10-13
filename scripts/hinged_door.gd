extends InteractableStaticBody3D

var open := false
@export var mesh : MeshInstance3D
@export var interactCollider : CollisionShape3D
var doorClosed := 0.0
@export var openDegrees := 150
@onready var doorOpen := doorClosed - openDegrees

func interact(_body):
	open = !open
	
func _process(_delta):
	if open and !(mesh.rotation_degrees.y == doorOpen):
		mesh.rotation_degrees.y = lerp(mesh.rotation_degrees.y, doorOpen, 0.01)
		interactCollider.rotation_degrees.y = mesh.rotation_degrees.y
	elif !open and !(mesh.rotation_degrees.y == doorClosed):
		mesh.rotation_degrees.y = lerp(mesh.rotation_degrees.y, doorClosed, 0.03)
		interactCollider.rotation_degrees.y = mesh.rotation_degrees.y
