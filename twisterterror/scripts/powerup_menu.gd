extends Control

func _ready():
	hide()
	Global.upgrade.connect(upgrade_menu)
	
func resume():
	hide()
	get_tree().paused = false

func upgrade_menu():
	show()
	$levelup.play()
	$levelup/levelupbounce.play("bounce")
	get_tree().paused = true
	$Options/Attack1.grab_focus()
	
func _on_attack_1_pressed() -> void:
	pass # Replace with function body.
	
func _on_attack_2_pressed() -> void:
	pass # Replace with function body.
	
func _on_attack_3_pressed() -> void:
	pass # Replace with function body.
	
func _on_skip_pressed() -> void:
	resume()
