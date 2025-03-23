extends CharacterBody2D

@export var health = 15

@onready var damage_timer = $DamageTimer
@onready var hurt_timer = $HurtAnimTimer
@onready var hurt = $hurt

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	hurt.play("RESET")
	
func _process(delta: float) -> void:
	rotation = lerp_angle(rotation,velocity.angle(),0.1) # Makes missile face player

func take_damage(num):
	health -= num
	if health <= 0:
		queue_free()
		Global.sadgen.emit()

func _on_hurt_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		take_damage(Global.spin_damage)
		hurt.play("hurt")
		print(health)
		damage_timer.start()
		hurt_timer.start()

func _on_hurt_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		damage_timer.stop()
		
func _on_damage_timer_timeout() -> void:
	take_damage(Global.spin_damage)
	hurt.play("hurt")
	hurt_timer.start()
	print(health)

func _on_hurt_anim_timer_timeout() -> void:
	hurt.play("RESET")

func _on_hurt_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.damage.emit()
		$hurt.play("RESET")
		$Detect/CollisionShape2D.disabled = true
		$HurtZone/CollisionShape2D.disabled = true
		$Seconds.visible = true
		$AnimatedSprite2D.play("explode")
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(.8).timeout
		queue_free()
