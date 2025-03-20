extends Area2D
@onready var health = 10
@onready var timer = $Timer

func take_damage(num):
	health -= num
	if health == 0:
		queue_free()
		#add xp

func _on_area_entered(area: Area2D) -> void:
	if area is Area2D:
		print("hello")
		take_damage(Global.spin_damage)
		print(health)
		timer.start(1)
	
func _on_area_exited(area: Area2D) -> void:
	if area is Area2D:
		print("byebye")
		timer.stop()
		


func _on_timer_timeout() -> void:
	take_damage(1)
	print(health)
