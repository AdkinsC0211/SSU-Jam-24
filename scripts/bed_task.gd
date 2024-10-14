extends InteractableStaticBody3D

var player_ref
var camera_return_location: Vector3
var toggle: bool = false
var neck_moved = false
var haunted = false
var salted = false
var player_near = false
var need_die

# Called when the node enters the scene tree for the first time.
func _ready():
	$ghost_light.visible = haunted
	$salt_ring.visible = false

var visited_targets = GameInfo.deadOrphans

func kill_orphan():
	var closest_target: Node3D = null
	var min_distance: float = INF
	
	var target_list = get_tree().get_nodes_in_group("orphans")
	if target_list:
		for target in target_list:
			if target in visited_targets:
				continue  # Skip if already visited

			var distance: float = global_position.distance_to(target.global_position)
			if distance < min_distance:
				min_distance = distance
				closest_target = target
		if not closest_target:
			var player = get_tree().get_first_node_in_group("Player")
			closest_target = player
		closest_target.die()
		visited_targets.append(closest_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_ref = body
		if player_ref.heldItem != null and player_ref.heldItem.is_in_group("salt") == true and haunted == true:
			get_salted_idiot()
			return
		toggle = !toggle
			
		camera_return_location = body.get_node("Neck").position
		if toggle:
			$Ruffle.play()
			if haunted:
				$MonsterCatch.play()
				need_die  = player_ref
			body.get_node("Neck").position += Vector3(0,-2.3,0)
			neck_moved = true
			$ghost_light.visible = false
			haunted = false
			
		else:
			body.get_node("Neck").position += Vector3(0,2.3,0)
			neck_moved = false
			$Ruffle.play()
		
func haunt():
	if salted:
		return
	$ghost_light.visible = true
	haunted = true
	$MonsterBreath.play_sound()
	$Timer.start(120)

func _on_area_3d_body_exited(body):
	if neck_moved and player_ref != null:
		body.get_node("Neck").position += Vector3(0,2.3,0)
		toggle = false
	player_ref = null
	player_near = false
	
	
func get_salted_idiot():
	if not salted:
		$salt_ring.visible = true
		salted = true
		haunted = false
		$ghost_light.visible = false
		$Ritual.play()
	


func _on_area_3d_body_entered(body):
	player_near = true


func _on_timer_timeout():
	if haunted == true:
		var demon = preload("res://scenes/Demon.tscn")
		var thisDemon = demon.instantiate()
		thisDemon.global_position = global_position
		var Orphanage = get_tree().get_first_node_in_group("orphanage")
		Orphanage.add_child(thisDemon)
		haunted = false
		kill_orphan()


func _on_monster_catch_finished():
	need_die.die()
