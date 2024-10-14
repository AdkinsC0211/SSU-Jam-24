extends Node2D

#@export var entrance : InteractableStaticBody3D
@export var rosary : GrabbableStaticBody3D
@export var dishes : WaitTimeTask
@export var window1 : InteractableStaticBody3D
@export var window2 : InteractableStaticBody3D
@export var window3 : InteractableStaticBody3D
@export var bed1 : InteractableStaticBody3D
@export var bed2: InteractableStaticBody3D
@export var bed3 : InteractableStaticBody3D
@export var bed4 : InteractableStaticBody3D
@export var bed5: InteractableStaticBody3D
@export var bed6 : InteractableStaticBody3D
#@export var closet1 : Node3D
#@export var closet2 : Node3D
#@export var closet3 : Node3D
@export var breaker : InteractableStaticBody3D
#@export var demon1 : CharacterBody3D
#@export var demon2 : CharacterBody3D
#@export var demon3 : CharacterBody3D
#@export var demon4 : CharacterBody3D
#@export var demon5 : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if entrance.locked == true:
	#	$CanvasLayer/PaperTexture/BigContainer/TaskContainer/EntranceLabel.visible = false
	#else:
	#	$CanvasLayer/PaperTexture/BigContainer/TaskContainer/EntranceLabel.visible = true
	if rosary.canPray == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/RosaryPrayerLabel.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/RosaryPrayerLabel.visible = true
	if dishes.task_complete == true:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/DoDishesLabel.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/DoDishesLabel.visible = true
	if window1.window_open == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow1.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow1.visible = true
	if window2.window_open == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow2.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow2.visible = true
	if window3.window_open == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow3.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CloseTheWindow3.visible = true
	if bed1.haunted == true:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/TopBedLabel.visible = true
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/TopBedLabel.visible = false
	if bed2.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel2.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel2.visible = true
	if bed3.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel3.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel3.visible = true
	if bed4.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel4.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel4.visible = true
	if bed5.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel5.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel5.visible = true
	if bed6.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel6.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/CheckBedLabel6.visible = true
	if breaker.haunted == false:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/FlipBreakerLabel.visible = false
	else:
		$CanvasLayer/PaperTexture/BigContainer/TaskContainer/FlipBreakerLabel.visible = true
	#add three closet and five demons
	
	
