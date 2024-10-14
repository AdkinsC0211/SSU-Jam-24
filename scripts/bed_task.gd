extends InteractableStaticBody3D

var player_ref
var camera_return_location: Vector3
var toggle: bool = false
var neck_moved = false
var haunted = false
var salted = false
var player_near = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ghost_light.visible = haunted
	$salt_ring.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(body: CharacterBody3D) -> void:
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
	$Timer.start()

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
	if haunt:
		var demon = preload("res://scenes/Demon.tscn")
		demon.instantiate()
		demon.global_position = global_position
		add_sibling(demon)
