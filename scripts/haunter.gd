extends Node3D

@export var hauntable_tasks_manager: Node3D

@onready var hauntable_items = hauntable_tasks_manager.get_child_count() - 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$haunt_timer.wait_time = randf_range(60, 80)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_haunt_timer_timeout():
	hauntable_tasks_manager.get_child(randi_range(0, hauntable_items)).haunt()
	$haunt_timer.wait_time = randf_range(10,25)
	
	
