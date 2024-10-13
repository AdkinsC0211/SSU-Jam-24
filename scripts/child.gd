extends InteractableCharacterBody3D

@export var player: CharacterBody3D
const speed = 2.5
const accel = 5
var target : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func interact(_body : CharacterBody3D) -> void:
	if target == player:
		target = Node3D.new()
		target.position = Vector3.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction : Vector3
	$NavigationAgent3D.target_position = target.global_position
	direction = $NavigationAgent3D.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
