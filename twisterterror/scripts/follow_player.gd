class_name FollowPlayer extends Node

@export var speed = 90
@export var health = 10

@onready var parent: CharacterBody2D = get_parent()

var start_position
var target: Player = null


func _ready() -> void:
	start_position = parent.position
	Global.damage.connect(stop)
	target = get_tree().get_first_node_in_group("player")

func update_velocity():
	if !target:
		# If the target is lost, try to find it again using the group
		target = get_tree().get_first_node_in_group("player")
		if !target:
			# If the player is still not found, stop updating velocity
			return
	
	# Ensure the target is valid before accessing its properties
	if is_instance_valid(target):
		var direction = target.global_position - parent.global_position
		var velocity = direction.normalized() * speed
		parent.velocity = velocity
	else:
		# If the target is invalid (e.g., destroyed), try to find it again
		target = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	update_velocity()
	parent.move_and_slide()
	
func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body
		
func stop():
	speed = 0
