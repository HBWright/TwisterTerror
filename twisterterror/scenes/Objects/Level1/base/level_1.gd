extends Area2D
@onready var health = 10
@onready var damage_timer = $DamageTimer
@onready var hurt_timer = $HurtAnimTimer
@onready var hurt = $hurt

func _ready():
	hurt.play("RESET")

func take_damage(num):
	health -= num
	$damage_taken.visible = true
	if health <= 0:
		Global.score += 10
		queue_free()
		Global.xp += 10

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		take_damage(Global.spin_damage)
		hurt.play("hurtEffect")
		print(health)
		damage_timer.start()
		hurt_timer.start()
	
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		damage_timer.stop()
		
func _on_damage_timer_timeout() -> void:
	take_damage(Global.spin_damage)
	hurt.play("hurtEffect")
	hurt_timer.start()
	print(health)
	
func _on_hurt_anim_timer_timeout() -> void:
	$damage_taken.visible = false
	hurt.play("RESET")
