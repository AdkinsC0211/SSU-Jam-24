# Interactable.gd
class_name WaitTimeTask
extends InteractableStaticBody3D

@export var completion_time: float = 10
@export var task_name = "task"

var task_complete: bool = false
var doing_task: bool = false
var player_ref
var filling_sink = false
var time_holder = 0
@onready var water_start = $water.position


#virtual function that can be overridden to affect how progress on tasks is shown
func make_progress() -> void:
	pass

func _ready() -> void:
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	$Timer.wait_time = completion_time
	$Timer.start()
	$Timer.set_paused(true)

func _process(delta):
	if filling_sink:
		#$water.translate(Vector3(0,.0*delta,0))
		$water.position.y = lerp(water_start.y,
		water_start.y + .3,
		 ($Timer.wait_time - $Timer.time_left)/$Timer.wait_time)
	
# Virtual function that can be overridden by child classes
func interact(body: CharacterBody3D) -> void:
	doing_task = !doing_task
	if body.name ==  "CharacterBody3D":
		player_ref = body
		player_ref.doing_wait_task = !player_ref.doing_wait_task
		if doing_task:
			filling_sink = true
			$Timer.set_paused(false)
			interactMessage = "Press E to stop doing " + task_name
		else:
			filling_sink = false
			$Timer.set_paused(true)
			interactMessage = "Press E to start doing " + task_name


func _on_timer_timeout():
	player_ref.doing_wait_task = false
	task_complete = true
	filling_sink = false
	$sink_collider.queue_free()
	for dish in $dish_manager.get_children():
		dish.queue_free()

	
	
