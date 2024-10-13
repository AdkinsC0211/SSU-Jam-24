extends CharacterBody3D


@onready var timer = $Timer
var player : CharacterBody3D
var speed = 5
var accel = 10

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("spookify"):
		body.spookify()
	if body.is_in_group("Player"):
		timer.start(28)
		player = body


func _on_timer_timeout() -> void:
	player.die()
	

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		timer.stop()
		player = null
	if body.has_method("unspookyify"):
		body.unspookify()

func _physics_process(delta: float) -> void:
	var direction = ($NavigationAgent3D.get_next_path_position() - global_position).normalized()
	velocity = lerp(velocity, direction * speed, delta * accel)

func chooseTarget() -> Node:
	# Get all nodes in the group "rooms"
	var rooms = get_tree().get_nodes_in_group("rooms")
	
	# Ensure the group is not empty
	if rooms.size() > 0:
		# Choose a random index from the list of rooms
		var random_index = randi() % rooms.size()
		
		# Return the randomly selected room node
		return rooms[random_index]
	else:
		print("No nodes found in group 'rooms'")
		return null
