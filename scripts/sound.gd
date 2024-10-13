extends AudioStreamPlayer3D

var player:CharacterBody3D
var space_state
var update_timer = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(_delta):
	space_state = get_world_3d().direct_space_state

func _process(delta: float) -> void:
	if playing and update_timer > 0 and stream.loop:
		update_timer -= delta
	elif playing and stream.loop:
		update_timer = 0.5
		var distance_vec = player.global_transform.origin - global_transform.origin
		var ray = global_transform.origin + (distance_vec).normalized()*20
		var query = PhysicsRayQueryParameters3D.create(global_transform.origin, ray)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result!={}:
			if result["collider"] is StaticBody3D:
				#if distance_vec.length() > 20:
				#	if bus != "Far & Muffled":
				#		bus = "Far & Muffled"
				if bus != "Muffled":
					bus = "Muffled"
			elif bus!="Master" and bus!= "Far":
				bus = "Master"
		#if distance_vec.length() > 20 and bus!="Far & Muffled":
		#	if bus != "Far":
		#		bus = "Far"
		elif bus!="Master":
			bus = "Master"
		print(bus)

func play_sound(time:float=0.0)-> void:
	var distance_vec = player.global_transform.origin - global_transform.origin
	var ray = global_transform.origin + (distance_vec).normalized()*20
	var query = PhysicsRayQueryParameters3D.create(global_transform.origin, ray)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result!={}:
		print(result["collider"])
		if result["collider"] is StaticBody3D:
			if distance_vec.length() > 20:
				if bus != "Far & Muffled":
					bus = "Far & Muffled"
			if bus != "Muffled":
				bus = "Muffled"
		elif bus!="Master" and bus!= "Far":
			bus = "Master"
	if distance_vec.length() > 20 and bus!="Far & Muffled":
		if bus != "Far":
			bus = "Far"
	elif bus!="Master":
		bus = "Master"
	play(time)
