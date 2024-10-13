extends Node3D

@export var bed : Node3D
@export var closet : Node3D
@export var window : Node3D

var isHaunted := false

func haunt():
	isHaunted = true
	match randi_range(1,3):
		1: bed.haunt()
		2: closet.haunt()
		3: window.haunt()
