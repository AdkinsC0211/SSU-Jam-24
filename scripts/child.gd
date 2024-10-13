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
				if blindsPreferOpen == blindsAreOpen:
					target_list = [bed]

#var behavior_table: Dictionary = {
	##[scared, need2pee, blindsPreferOpen, windowOpen, powerOn]
	#[0, 0, 0, 0, 0]: [],  # 00000 # get scared
	#[0, 0, 0, 0, 1]: [],  # 00001 # could be perfect conditions, check blinds, sleep
	#[0, 0, 0, 1, 0]: [],  # 00010 # get scared
	#[0, 0, 0, 1, 1]: [],  # 00011 # close window
	#[0, 0, 1, 0, 0]: [],  # 00100 # get scared
	#[0, 0, 1, 0, 1]: [],  # 00101 # could be perfect conditions, check blinds, sleep
	#[0, 0, 1, 1, 0]: [],  # 00110 # get scared
	#[0, 0, 1, 1, 1]: [],  # 00111 # close window
	#[0, 1, 0, 0, 0]: [],  # 01000 # get scared
	#[0, 1, 0, 0, 1]: [],  # 01001 # go pee
	#[0, 1, 0, 1, 0]: [],  # 01010 # get scared
	#[0, 1, 0, 1, 1]: [],  # 01011 # go pee
	#[0, 1, 1, 0, 0]: [],  # 01100 # get scared
	#[0, 1, 1, 0, 1]: [],  # 01101 # go pee
	#[0, 1, 1, 1, 0]: [],  # 01110 # get scared
	#[0, 1, 1, 1, 1]: [],  # 01111 # g
	#[1, 0, 0, 0, 0]: [],  # 10000 # below here, scared takes priority, look for player
	#[1, 0, 0, 0, 1]: [],  # 10001
	#[1, 0, 0, 1, 0]: [],  # 10010
	#[1, 0, 0, 1, 1]: [],  # 10011
	#[1, 0, 1, 0, 0]: [],  # 10100
	#[1, 0, 1, 0, 1]: [],  # 10101
	#[1, 0, 1, 1, 0]: [],  # 10110
	#[1, 0, 1, 1, 1]: [],  # 10111
	#[1, 1, 0, 0, 0]: [],  # 11000
	#[1, 1, 0, 0, 1]: [],  # 11001
	#[1, 1, 0, 1, 0]: [],  # 11010
	#[1, 1, 0, 1, 1]: [],  # 11011
	#[1, 1, 1, 0, 0]: [],  # 11100
	#[1, 1, 1, 0, 1]: [],  # 11101
	#[1, 1, 1, 1, 0]: [],  # 11110
	#[1, 1, 1, 1, 1]: []   # 11111
#}


# State table (key: tuple of conditions, value: list of targets)
#var behavior_table: Dictionary = {
	#(true, false, false, false, true): [playerBedroom, kitchen, church],  # Scared, power on
	#(false, true, false, false, true): [bathroom],  # Need to pee, power on
	#(false, true, false, false, false): [playerBedroom],  # Need to pee, power off
	#(false, false, true, false, true): [window],  # Window is open
	#(false, false, false, true, true): [window],  # Blinds need adjustment
	#(false, false, false, false, true): [bed],  # Default: go to bed
	#(false, false, false, false, false): [bed],  # Default with power off
#}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

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

func interact(_body: CharacterBody3D) -> void:
	followingPlr = false

# Called every physics frame
func _physics_process(delta: float) -> void:
	if velocity and not $Walking/AnimationPlayer.is_playing():
		$Walking/AnimationPlayer.play("mixamo_com")
	elif not velocity:
		$Walking/AnimationPlayer.stop()
		
	global_rotation = Vector3.ZERO

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	getCurrentTargetPosition()

	# Navigate toward the current target
	$NavigationAgent3D.target_position = current_target.global_position
	var direction = ($NavigationAgent3D.get_next_path_position() - global_position).normalized()
	look_at(Vector3($NavigationAgent3D.get_next_path_position().x, global_position.y, $NavigationAgent3D.get_next_path_position().z))
	
	velocity = lerp(velocity, direction * speed, delta * accel)
	
	# Stop near player
	if global_position.distance_to(player.global_position) <= 3:
		velocity = Vector3.ZERO
	
	move_and_slide()


func getCurrentTargetPosition() -> void:
	#curConditions = [scared, need2Pee, blindsPreferOpen, windowOpen, powerOn]
	#print("curConditions: ", curConditions)
	if not followingPlr:
		choose_behavior()
	current_target = find_closest_target()

func _on_navigation_agent_3d_target_reached() -> void:
		visited_targets.append(current_target)
		if len(visited_targets) == len(target_list):
			visited_targets = [] # if you've seen them all, start over


func _on_plr_detector_body_entered(body: Node3D) -> void:
	if body == player and body and lookingForPlr:
		target_list = [player]
		followingPlr = true
		
