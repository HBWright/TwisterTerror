class_name Player_Overworld extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var default_hurtbox = $Area2D/CollisionShape2D

@export var speed : float = 100
@export var accel : float = 10
var direction : Vector2

func _ready():
	anim.play()
	anim.scale = Vector2(1,1)
	
func _process(delta: float) -> void:
	anim.scale.x = Global.player_size
	anim.scale.y = Global.player_size
	
	collision.scale.x = Global.player_size
	collision.scale.y = Global.player_size
	collision.position.y = Global.player_collision_y
	
	default_hurtbox.scale.x = Global.player_size
	default_hurtbox.scale.y = Global.player_size
	
func _physics_process(_delta: float) -> void:
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	
	if direction.y:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, speed * direction.y, accel)
		
	move_and_slide()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Area2D:
		print("helloooooooo")
