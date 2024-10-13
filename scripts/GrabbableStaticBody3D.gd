class_name GrabbableStaticBody3D
extends InteractableStaticBody3D

@export var mesh : MeshInstance3D
@export var collider : CollisionShape3D
@export var target : Node3D

var player : CharacterBody3D

var targetVector : Vector3

@export var interactMessageSecondary = "Press E to Swap Items"

func _ready() -> void:
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	interactMessage = "Press E to Pick up"  # I can't overwrite the default for this any other way as far as I am aware

func interact(body) -> void:
	if body.handsFull:
		body.dropItem(global_position)
	collider.disabled = true
	target = body.hand
	player = body
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, 5 * delta)

func use() -> void:
	pass

func dropItem(pos : Vector3) -> void:
	global_position = pos
	collider.disabled = false
	target = null
