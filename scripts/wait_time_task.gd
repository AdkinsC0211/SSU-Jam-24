# Interactable.gd
class_name WaitTimeTask
extends InteractableStaticBody3D

@export var completion_time: float = 4.5
@export var saves_progress: bool = true
@export var task_name = "task"

var task_complete: bool = false
var doing_task: bool = false
var player_ref
#@export var progress_bar: ProgressBar

#virtual function that can be overridden to affect how progress on tasks is shown
func make_progress() -> void:
	pass

func _ready() -> void:
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	$Timer.wait_time = completion_time
	#progress_bar.visible = false
	
func _process(_delta):
	#progress_bar.value = $Timer.time_left / $Timer.wait_time * 100
	
# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	doing_task = !doing_task
	if body.name ==  "CharacterBody3D":
		player_ref = body
		player_ref.doing_wait_task = !player_ref.doing_wait_task
		if doing_task:
			$Timer.start()
			#progress_bar.visible = true
			interactMessage = "Press E to stop doing " + task_name
		else:
			$Timer.stop()
			#progress_bar.visible = false
			interactMessage = "Press E to start doing " + task_name
			if not saves_progress:
				$Timer.time_left = completion_time

func _on_timer_timeout():
	player_ref.doing_wait_task = false
	task_complete = true
	$sink_collider.queue_free()
	

	
	
