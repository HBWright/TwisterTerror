extends Control

@onready var anim = $AnimatedSprite2D
@onready var logo = $AnimationPlayer

func _ready() -> void:
	$Main/Play.grab_focus()
	anim.play()
	logo.play("Logo Twist")
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/town.tscn")
	
func _on_controls_pressed() -> void:
	$Main.visible = false
	$Controls.visible = true
	$back.visible = true
	$back.grab_focus()

func _on_credits_pressed() -> void:
	$Main.visible = false
	$Credits.visible = true
	$back.visible = true
	$back.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit() 
	
func _on_back_pressed() -> void:
	$Main.visible = true
	$Credits.visible = false
	$Controls.visible = false
	$back.visible = false
	$Main/Play.grab_focus()
