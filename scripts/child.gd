extends InteractableCharacterBody3D

var player : CharacterBody3D
const speed = 1.5
const accel = 5
var target_list: Array[Node3D] = []
var visited_targets: Array[Node3D] = []
var current_target: Node3D = null
var followingPlr := false
var pathfinding := true

# Points of interest
@export var bedroom: Node3D
@export var bed: Node3D
@export var desk: Node3D
@export var closet: Node3D
@export var window: Node3D
@export var playerBedroom: Node3D
@export var kitchen: Node3D
@export var bathroom: Node3D
@export var church: Node3D

var LeftLegTarget : Node3D
var RightLegTarget : Node3D
var LeftLegStart : Vector3
var RightLegStart : Vector3
var LeftLegEnd : Vector3
var RightLegEnd : Vector3

# Blinds real position
@export var blindsAreOpen := false

# Conditions
@export var scared: bool = false
@export var need2Pee: bool = false
@export var blindsPreferOpen: bool = false
@export var windowOpen: bool = false
@export var powerOn: bool = true
@export var lookingForPlr := false

@export var asleep := false

@onready var curConditions = [scared, need2Pee, blindsPreferOpen, windowOpen, powerOn]

func choose_behavior() -> void:
	if scared:
		# look for player
		target_list = [playerBedroom, kitchen, church, bedroom]
		lookingForPlr = true
	else:
		if powerOn:
			# get scared
			scared = true
		else:
			if need2Pee:
				#go pee
				target_list = [bathroom]
			else:
				#check blinds, sleep
				blindsAreOpen = window.blindsOpen
				if blindsPreferOpen == blindsAreOpen:
					target_list = [bed]
					asleep = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	$PPTimer.start(randi_range(120,1200))

# Find the closest unvisited target
func find_closest_target() -> Node3D:
	var closest_target: Node3D = null
	var min_distance: float = INF

	for target in target_list:
		if target in visited_targets:
			continue  # Skip if already visited

		var distance: float = global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			closest_target = target
	return closest_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func die():
	queue_free()

func interact(_body: CharacterBody3D) -> void:
	followingPlr = false
	scared = false

# Called every physics frame
func _physics_process(delta: float) -> void:
	if not asleep:
		if velocity and not $Walking/AnimationPlayer.is_playing():
			$Walking/AnimationPlayer.play("mixamo_com")
		elif not velocity:
			$Walking/AnimationPlayer.stop()
			
		global_rotation = Vector3.ZERO

		# Add gravity
		if not is_on_floor():
			velocity += get_gravity() * delta
		if velocity and not $Walking/AnimationPlayer.is_playing():
			$Walking/AnimationPlayer.play("mixamo_com")
		elif not velocity:
			$Walking/AnimationPlayer.stop()
		if velocity and not $Footstep.playing:
			$Footstep.play_sound()
			
			getCurrentTargetPosition()

		# Navigate toward the current target
		$NavigationAgent3D.target_position = current_target.global_position
		var direction = ($NavigationAgent3D.get_next_path_position() - global_position).normalized()
		look_at(Vector3($NavigationAgent3D.get_next_path_position().x, global_position.y, $NavigationAgent3D.get_next_path_position().z))
		
		velocity = lerp(velocity, direction * speed, delta * accel)
		
		# Stop near player
		if global_position.distance_to(player.global_position) <= 3:
			velocity = Vector3.ZERO
			if lookingForPlr:
				if need2Pee:
					target_list = [bathroom]
				else:
					target_list = [bedroom]
				lookingForPlr = false
		
		move_and_slide()


func getCurrentTargetPosition() -> void:
	#curConditions = [scared, need2Pee, blindsPreferOpen, windowOpen, powerOn]
	#print("curConditions: ", curConditions)
	if not followingPlr:
		choose_behavior()
	current_target = find_closest_target()

func _on_navigation_agent_3d_target_reached() -> void:
		visited_targets.append(current_target)
		if current_target == bathroom:
			need2Pee = false
		if len(visited_targets) == len(target_list):
			visited_targets = [] # if you've seen them all, start over
		


func _on_plr_detector_body_entered(body: Node3D) -> void:
	if body == player and body and lookingForPlr:
		target_list = [player]
		followingPlr = true
		


func _on_pp_timer_timeout() -> void:
	need2Pee = true
	$PPTimer.start(randi_range(120,1200))
