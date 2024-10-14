extends InteractableStaticBody3D

@onready var window_delay_time = randf_range(0.3, 2.0)
@onready var timer = $break_open_delay
@export var blindsOpen : bool

@export var spoopy_window: bool
var haunted: bool = false

#window_variables
var window_open: bool = false
var one_for_the_one_time = true

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = window_delay_time
	if spoopy_window == false:
		$Area3D.queue_free()
	$Blinds.interactMessage = "Press E to close blinds"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	blindsOpen = $Blinds.blinds_open
	if window_open and $Wind.playing==false:
		$Wind.play_sound()
	elif not window_open:
		if not $AnimationPlayer.is_playing():
			$Wind.stop()
			if one_for_the_one_time:
				$Close.play()
				one_for_the_one_time = false
	
func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and window_open == false:
		timer.start()
	


func _on_break_open_delay_timeout():
	if $Blinds.blinds_open == false:
		$Blinds/AnimationPlayer.play("open_blinds")
		
	$AnimationPlayer.active = true
	$AnimationPlayer.play("open_window",-1,1,false)
	$AnimationPlayer.speed_scale = 8
	window_open = true
	if $Area3D:
		$Area3D.queue_free()
	$Open.play_sound()
	haunted = true
	
	$Timer.start()


func interact(body: Node3D) -> void:
	$AnimationPlayer.active = true
	$AnimationPlayer.speed_scale = 1
	one_for_the_one_time = true
	if !$Blinds.blinds_open:
		self.interactMessage = "Blinds are closed"
	else:
		if !window_open:
			$AnimationPlayer.play("open_window",-1,1,false)
			self.interactMessage = "Press E to close window"
			$Blinds.interactMessage = "Window is open"
		else:
			$AnimationPlayer.play_backwards("open_window",-1)
			self.interactMessage = "Press E to open window"
			$Blinds.interactMessage = "Press E to close blinds"
			haunted = false
		window_open = !window_open
		
		
func haunt():
	_on_break_open_delay_timeout()

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


func _on_timer_timeout():
	if haunted == true:
		var demon = preload("res://scenes/Demon.tscn")
		var thisDemon = demon.instantiate()
		thisDemon.global_position = global_position
		var Orphanage = get_tree().get_first_node_in_group("orphanage")
		Orphanage.add_child(thisDemon)
		haunted = false
		kill_orphan()
