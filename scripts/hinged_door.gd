extends Area3D

var open := false
@export var mesh : MeshInstance3D
@export var collider : CollisionShape3D
@export var interactCollider : CollisionShape3D
var doorClosed := 0.0
var doorOpen := doorClosed - 105.0

@onready var OpenSound = AudioStreamPlayer3D.new()
@onready var CloseSound = AudioStreamPlayer3D.new()

func _ready():
	OpenSound.bus = "SoundEffects"
	CloseSound.bus = "SoundEffects"
	#OpenSound.stream = preload(" path to open sound")
	#CloseSound.stream = preload("path to close sound")
	add_child(OpenSound)
	add_child(CloseSound)

func interact(body):
	open = !open
	if open:
		OpenSound.play()
	else:
		CloseSound.play()
	return body
	
func _process(delta):
	if open and !(mesh.rotation_degrees.y == doorOpen):
		mesh.rotation_degrees.y = lerp(mesh.rotation_degrees.y, doorOpen, 0.01)
		collider.rotation_degrees.y = mesh.rotation_degrees.y
		interactCollider.rotation_degrees.y = mesh.rotation_degrees.y
	elif !open and !(mesh.rotation_degrees.y == doorClosed):
		mesh.rotation_degrees.y = lerp(mesh.rotation_degrees.y, doorClosed, 0.03)
		collider.rotation_degrees.y = mesh.rotation_degrees.y
		interactCollider.rotation_degrees.y = mesh.rotation_degrees.y
