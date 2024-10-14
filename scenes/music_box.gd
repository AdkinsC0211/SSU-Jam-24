extends StaticBody3D


func use() -> void:
	# do something
	var closets = get_tree().get_nodes_in_group("closets")
	for closet in closets:
		if global_position.distance_to(closet) < 5:
			closet.unhaunt()
			$AudioStreamPlayer3D.play_sound()
			$AudioStreamPlayer3D2.play_sound()
