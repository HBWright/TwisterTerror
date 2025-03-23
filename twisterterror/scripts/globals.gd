extends Node

@export var score = 0
@export var highScore = 0

@export var player_size = 1
@export var camera_zoom = 4
@export var player_collision_y = 2
@export var spin_damage = 5

@export var xp = 0
@export var xp_goal = 100
@export var level = 0

signal upgrade
signal death
signal hurt
signal heal
signal damage
signal sadgen

signal level5
signal level10
signal level15
signal level20
signal level25
signal level30

func _ready() -> void:
	Global.score = 0
	Global.highScore = 0
	Global.player_size = 1
	Global.camera_zoom = 4
	Global.player_collision_y = 2
	Global.spin_damage = 5
	Global.xp = 0
	Global.xp_goal = 100
	Global.level = 0
	#emit_signal("upgrade")
