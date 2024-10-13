extends InteractableStaticBody3D

var open := false
@export var mesh : MeshInstance3D
@export var interactCollider : CollisionShape3D

# Enum for axis selection
enum Axis { X, Y, Z }
@export var axis : Axis = Axis.Y

var doorClosed := 0.0
@export var openDegrees := 150
@onready var doorOpen := doorClosed - openDegrees
var just_closed = true

func interact(_body):
	if open: # closing door
		just_closed = false
		$DoorMove.play_sound()
		open = !open
		interactMessage = "Press E to open door"
		if $Door2/Door/Lock.locked:
			interactMessage = "Door is locked"
	elif $Door2/Door/Lock.locked == false:
		open = !open
		interactMessage = "Press E to close door"
		$DoorMove.play_sound()
	else:
		interactMessage = "Door is locked"
		return

func _process(delta):
	if open and !is_door_fully_open():
		rotate_door(doorOpen, delta)
	elif !open and !is_door_fully_closed():
		rotate_door(doorClosed,delta)
	if is_door_fully_closed() and not just_closed:
		just_closed = true
		$DoorClose.play_sound()

# Function to rotate the door along the selected axis
func rotate_door(target_rotation,delta):
	match axis:
		Axis.X:
			mesh.rotation_degrees.x = move_toward(mesh.rotation_degrees.x, target_rotation, delta*100)
			interactCollider.rotation_degrees.x = mesh.rotation_degrees.x
		Axis.Y:
			mesh.rotation_degrees.y = move_toward(mesh.rotation_degrees.y, target_rotation, delta*100)
			interactCollider.rotation_degrees.y = mesh.rotation_degrees.y
		Axis.Z:
			mesh.rotation_degrees.z = move_toward(mesh.rotation_degrees.z, target_rotation, delta*100)
			interactCollider.rotation_degrees.z = mesh.rotation_degrees.z

# Helper functions to check if the door is fully open or closed
func is_door_fully_open() -> bool:
	match axis:
		Axis.X: return mesh.rotation_degrees.x == doorOpen
		Axis.Y: return mesh.rotation_degrees.y == doorOpen
		Axis.Z: return mesh.rotation_degrees.z == doorOpen
	return 0

func is_door_fully_closed() -> bool:
	match axis:
		Axis.X: return mesh.rotation_degrees.x == doorClosed
		Axis.Y: return mesh.rotation_degrees.y == doorClosed
		Axis.Z: return mesh.rotation_degrees.z == doorClosed
	return 0
