extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false
	hide()
	
func pause():
	$PanelContainer/VBoxContainer/Resume.grab_focus()
	get_tree().paused = true
	show()

func test_pause():
	if Input.is_action_just_pressed("Pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused == true:
		resume()
	
func _process(float):
	test_pause()
	
func _on_resume_pressed():
	resume()

func _on_controls_pressed():
	$PanelContainer.visible = false
	$Controls.visible = true
	$Controls/back.grab_focus()
	
func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed()  -> void :
	get_tree().quit()

func _on_back_pressed() -> void:
	$PanelContainer.visible = true
	$Controls.visible = false
	$PanelContainer/VBoxContainer/Resume.grab_focus()
