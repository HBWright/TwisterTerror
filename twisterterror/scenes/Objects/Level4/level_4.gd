extends Area2D
@onready var health = 40
@onready var damage_timer = $DamageTimer
@onready var hurt_timer = $HurtAnimTimer
@onready var hurt = $hurt

func _ready():
	hurt.play("RESET")

func take_damage(num):
	health -= num
	if health <= 0:
		Global.score += 40
		queue_free()
		Global.xp += 40
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		take_damage(Global.spin_damage)
		hurt.play("hurtEffect")
		print(health)
		damage_timer.start()
		hurt_timer.start()
	
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("byebye")
		damage_timer.stop()

func _on_damage_timer_timeout() -> void:
	take_damage(Global.spin_damage)
	hurt.play("hurtEffect")
	hurt_timer.start()
	print(health)
	
func _on_hurt_anim_timer_timeout() -> void:
	hurt.play("RESET")
