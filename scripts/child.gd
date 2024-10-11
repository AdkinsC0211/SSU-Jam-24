extends InteractableCharacterBody3D

@export var player: CharacterBody3D
const speed = 2.5
const accel = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction : Vector3
	$NavigationAgent3D.target_position = player.global_position
	direction = $NavigationAgent3D.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
