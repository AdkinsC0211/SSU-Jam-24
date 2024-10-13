extends GrabbableStaticBody3D

var canPray = true
var praying = false
@export var cross : StaticBody3D


func _process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, 5 * delta)
	if just_picked:
		$PickUp.play()
		just_picked = false

func use() -> void:
	if praying:
		$Pray.stop()
		print("stopped praying")
		praying = !praying
		player.doing_wait_task = false
		$prayerTimer.paused = true
	else:
		$Pray.play()
		
	if global_position.distance_to(cross.global_position) < 3 and not praying and canPray:
		player.doing_wait_task = true
		print('praying')
		$prayerTimer.start()
		praying = !praying
	
	
	
	
	


func _on_prayer_timer_timeout():
	canPray = false
	praying = false
	player.doing_wait_task = false
	print("prayed!")
