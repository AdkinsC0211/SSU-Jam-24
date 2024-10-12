extends CharacterBody3D

@export var handsFull := false
@export var hand : Node3D

#relative constants
const JUMP_VELOCITY = 4.5
var SENSITIVITY = GameInfo.sensitivity
const WALKSPEED := 3.0
const RUNSPEED := 6.0
var BASE_FOV := GameInfo.fov
const FOV_CHANGE := 1.25

const BOB_FREQ := 2.0
const BOB_AMP := 0.08

#onready vars
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

#globals
var speed = WALKSPEED
var t_bob := 0.00
var heldItem : GrabbableStaticBody3D


func _ready() -> void:
	if not hand:
		hand = $Neck/Camera3D/Hand
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_head_bobs(delta)
	handle_fov_change(delta)
	handle_interactions()
	move_and_slide()

func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("Shift"):
		speed = RUNSPEED
	else:
		speed = WALKSPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * WALKSPEED, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * WALKSPEED, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * WALKSPEED, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * WALKSPEED, delta * 3.0)

func handle_head_bobs(delta: float) -> void:
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/2) * BOB_AMP
	return pos

func handle_fov_change(delta: float) -> void:
	var velocity_clamped = clamp(velocity.length(), 0.5, RUNSPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$PauseMenu.visible = true
		get_tree().paused = true
	if event.is_action_pressed("F") and $Neck/Camera3D/PlaceRaycast.is_colliding():
		dropItem($Neck/Camera3D/PlaceRaycast.get_collision_point())
		heldItem = null
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * SENSITIVITY)
			#rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(90))

func handle_interactions() -> void:
	if $Neck/Camera3D/InteractRaycast.is_colliding():
		var collider = $Neck/Camera3D/InteractRaycast.get_collider()
		if collider.has_method("interact"):
			if collider is GrabbableStaticBody3D:
				if not handsFull:
					$GeneralAI/InteractionMessage.text = collider.interactMessage
				else:
					$GeneralAI/InteractionMessage.text = collider.interactMessageSecondary
			else:
				$GeneralAI/InteractionMessage.text = collider.interactMessage
			if Input.is_action_just_pressed("E"):
				collider.interact(self)
				if collider is GrabbableStaticBody3D:
					heldItem = collider
					handsFull = true
	else:
		$GeneralAI/InteractionMessage.text = "" # Purposefully empty string

func _on_interact_range_body_entered(body: Node3D) -> void:
	if body.has_method("interact"):
		$Crosshair.visible = true

func dropItem(pos : Vector3):
	if heldItem:
		heldItem.dropItem(pos)
		handsFull = false

func _on_interact_range_body_exited(body: Node3D) -> void:
	if body.has_method("interact"):
		$Crosshair.visible = false
		
