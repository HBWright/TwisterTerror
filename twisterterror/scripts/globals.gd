extends Node

@export var score = 0
@export var highScore = 0

@export var player_size = 1
@export var player_collision_y = 2
@export var spin_damage = 10

@export var xp = 0
@export var xp_goal = 100
@export var level = 0

signal upgrade
signal death
signal hurt

func _ready() -> void:
	emit_signal("upgrade")
