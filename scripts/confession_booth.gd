extends InteractableStaticBody3D

var haunted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$ghost_light.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func interact(body: Node3D) -> void:
	if haunted:
		$Saved.play()
	haunted = false
	$ghost_light.visible = false
	
	
	
	
func haunt():
	haunted = true
	$ghost_light.visible = true
