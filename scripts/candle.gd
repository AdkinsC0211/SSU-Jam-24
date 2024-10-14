extends GrabbableStaticBody3D

@export var burnoutRate := 10.0
@export var baseRange := 7.5

func use() -> void:
	$Candle/OmniLight3D.visible = !$Candle/OmniLight3D.visible

func _ready() -> void:
	$"Burnout Counter".start(burnoutRate)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	interactMessage = "Press E to Pick up"
	$Flame.play_sound()
	$Candle/OmniLight3D.visible = false

func _on_burnout_counter_timeout() -> void:
	if $Candle/OmniLight3D.visible:
		$Candle.scale.y -= 0.1
	$Candle/OmniLight3D.omni_range = baseRange * $Candle.scale.y
	if $Candle.scale.y < 0.1:
		if player:
			player.handsFull = false
		player.handsFull = false
		$Extinguish.detatch_play()
		queue_free()
	$"Burnout Counter".start(burnoutRate)
