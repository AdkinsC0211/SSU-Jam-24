extends Node3D

var canPray = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $player.doing_wait_task == true and Input.is_action_just_released("E"):
		$player.doing_wait_task = false
		print("stopped praying")
		$prayerTimer.paused = true	
		
	if canPray and Input.is_action_just_pressed("E"):
		$player.doing_wait_task = true
		print("praying")
		$prayerTimer.start()
	

func _on_area_3d_body_entered(body):
	canPray = true
	print("can pray")


func _on_area_3d_body_exited(body):
	canPray = false
	print("can't pray")


func _on_prayer_timer_timeout():
	print("prayed!")
	$player.doing_wait_task = false
