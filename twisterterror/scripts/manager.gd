extends Control

@onready var anim = $TV
@onready var xp_bar = $xp_bar

func _ready() -> void:
	anim.play()
	xp_bar.set_max(Global.xp_goal)
	
func _process(delta):
	xp_bar.set_value(Global.xp)
	if Global.xp >= Global.xp_goal:
		level_up()

func level_up():
	Global.level += 1
	if Global.level % 2 == 0:
		Global.upgrade.emit()
	player_size()
	Global.xp -= Global.xp_goal
	Global.xp_goal += 100
	xp_bar.set_max(Global.xp_goal)

func player_size():
	Global.player_size += .1
	Global.player_collision_y += .2
