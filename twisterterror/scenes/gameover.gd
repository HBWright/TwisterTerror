extends Control


func _ready() -> void:
	$PanelContainer/VBoxContainer/main_menu.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit() 

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
