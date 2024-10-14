extends Node3D

var visited_targets = GameInfo.deadOrphans
var haunted = false

func haunt():
	$AudioStreamPlayer3D.play()
	$Timer.start(120)
	haunted = true
	
	
func unhaunt():
	$AudioStreamPlayer3D.stop()
	$Timer.stop()
	haunted = false

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


func spawn_demon():
	var demon = preload("res://scenes/Demon.tscn")
	var thisDemon = demon.instantiate()
	thisDemon.global_position = global_position
	var Orphanage = get_tree().get_first_node_in_group("orphanage")
	Orphanage.add_child(thisDemon)
	haunted = false

func _on_timer_timeout() -> void:
	kill_orphan()
	spawn_demon()
	unhaunt()
