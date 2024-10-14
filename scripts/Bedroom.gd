extends Node3D

@export var bed1 : Node3D
@export var bed2 : Node3D
@export var closet : Node3D
@export var window : Node3D

@export var whatsHaunted := -1

var isHaunted := false

func haunt():
	isHaunted = true
	whatsHaunted = randi_range(0,3)
	match whatsHaunted:
		1: bed1.haunt()
		1: bed2.haunt()
		2: closet.haunt()
		3: window.haunt()
