extends Control

@onready var mainGroup = $CenterContainer/mainGroup
@onready var pauseGroup = $CenterContainer/pauseGroup
@onready var optionGroup = $CenterContainer/optionsGroup
var inMain = true

# Called when the node enters the scene tree for the first time.
func _ready():
	mainGroup.visible = true
	pauseGroup.visible = false
	optionGroup.visible = false
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/fovSlider.value = GameInfo.fov
	$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/sensSlider.value = GameInfo.sensitivity
	#$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/volSlider.value = GameInfo.volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_resume_button_pressed():
	print("resumed!")
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_option_button_pressed():
	mainGroup.visible = false
	pauseGroup.visible = false
	optionGroup.visible = true

func _on_mainmenu_button_pressed():
	get_tree().reload_current_scene()


func _on_options_back_button_pressed():
	if inMain:
		mainGroup.visible = true
		pauseGroup.visible = false
		optionGroup.visible = false
	else:
		mainGroup.visible = false
		pauseGroup.visible = true
		optionGroup.visible = false


func _on_play_button_pressed():
	visible = false
	$mainBGimage.visible = false
	mainGroup.visible = false
	pauseGroup.visible = true
	optionGroup.visible = false
	inMain = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_group_visibility_changed():
	$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/fovSlider.value = GameInfo.fov
	$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/sensSlider.value = GameInfo.sensitivity
	$CenterContainer/optionsGroup/CenterContainer/VBoxContainer/volSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))


func _on_fov_slider_value_changed(value):
	GameInfo.fov = value
	print(GameInfo.fov)


func _on_sens_slider_value_changed(value):
	GameInfo.sensitivity = value


func _on_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	
