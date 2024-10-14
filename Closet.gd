extends Node3D

var visited_targets : Array = []

func haunt():
	$AudioStreamPlayer3D.play()
	$Timer.start(120)
	
	
func unhaunt():
	$AudioStreamPlayer3D.stop()

func kill_orphan():
	var closest_target: Node3D = null
	var min_distance: float = INF
	
	var target_list = get_tree().get_first_node_in_group("orphans")
	
	if len(target_list) == 0:
		var player = get_tree().get_first_node_in_group("Player")
		player.die()
	
	for target in target_list:
		if target in visited_targets:
			continue  # Skip if already visited

		var distance: float = global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			closest_target = target
	closest_target.die()
	visited_targets.append(closest_target)


func spawn_demon():
	var demon = preload("res://scenes/Demon.tscn")
	demon.instantiate()
	demon.global_position = global_position
	add_sibling(demon)

func _on_timer_timeout() -> void:
	kill_orphan()
	spawn_demon()
	unhaunt()
