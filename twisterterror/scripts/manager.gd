extends Control

@onready var anim = $TV
@onready var timespin = $cyclone/cyclonespin
@onready var xp_bar = $xp_bar
@onready var dt = $"Death Timer"

func _ready() -> void:
	$levelup.visible = false
	dt.start(31)
	anim.play()
	timespin.play("spin")
	xp_bar.set_max(Global.xp_goal)
	
func _process(delta):
	xp_bar.set_value(Global.xp)
	if Global.xp >= Global.xp_goal:
		level_up()
	if dt.time_left <= 10 :
		Global.hurt.emit()
	$timedisplay.text = str(str(int(dt.time_left)))

func level_up():
	Global.level += 1
	
	if Global.level % 2 == 0:
		Global.upgrade.emit()
	else:
		level_celebrate()
	
	player_size()
	
	dt.start(31)
	
	Global.xp -= Global.xp_goal
	Global.xp_goal += 100
	xp_bar.set_max(Global.xp_goal)

func player_size():
	Global.player_size += .1
	Global.player_collision_y += .2
	
func level_celebrate():
	$levelup.visible = true
	$levelup.play()
	$levelup/levelupbounce.play("levelupbounce")
	await get_tree().create_timer(2).timeout
	$levelup.visible = false
	
func _on_death_timer_timeout() -> void:
	Global.death.emit()
