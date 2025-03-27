extends Control

@onready var anim = $TV
@onready var timespin = $cyclone/cyclonespin
@onready var xp_bar = $xp_bar
@onready var dt = $"Death Timer"
var time: int 

func _ready() -> void:
	Global._ready()
	$levelup.visible = false
	dt.start(61)
	anim.play()
	timespin.play("spin")
	xp_bar.set_max(Global.xp_goal)
	Global.damage.connect(damage)
	Global.sadgen.connect(sadgen)
	
func _process(delta):
	xp_bar.set_value(Global.xp)
	if Global.xp >= Global.xp_goal:
		level_up()
	time = dt.time_left
	if time <= 10 && time != 0 :
		Global.hurt.emit()
	$timedisplay.text = str(str(int(dt.time_left)))

func level_up():
	Global.level += 1
	
	#if Global.level % 2 == 0:
		#Global.upgrade.emit()
	#else:
	level_celebrate()
	
	player_size()
	
	Global.heal.emit()
	
	dt.start(61)
	
	Global.xp -= Global.xp_goal
	Global.xp_goal += 100
	xp_bar.set_max(Global.xp_goal)
	if Global.level <= 4:
		anim.play("weather")
		await get_tree().create_timer(3).timeout
		anim.play("static")
	elif Global.level <= 5:
		Global.spin_damage = 6
		Global.level5.emit()
		anim.play("talking")
		await get_tree().create_timer(2).timeout
		idle_gen()
	elif Global.level <= 14:
		Global.spin_damage = 7
		Global.level10.emit()
		anim.play("screaming")
		await get_tree().create_timer(2).timeout
		idle_gen()
	elif Global.level >= 15:
		Global.spin_damage = 8
		Global.level15.emit()
		anim.play("furious")
		await get_tree().create_timer(2).timeout
		idle_gen()

func player_size():
	Global.player_size += .1
	Global.player_collision_y += .2
	Global.camera_zoom -= .1
	
func level_celebrate():
	$levelup.visible = true
	$levelup.play()
	$levelup/levelupbounce.play("levelupbounce")
	$"levelup ding".play()
	await get_tree().create_timer(2).timeout
	$levelup.visible = false
	
func _on_death_timer_timeout() -> void:
	Global.death.emit()
	$"Death Timer".stop()
	
	
func damage():
	time -= 10
	if time <= 0:
		dt.stop()
		dt.emit_signal("timeout")
	else:
		dt.start(time)
		anim.play("static")
		await get_tree().create_timer(.2).timeout
		anim.play("laughing")
		await get_tree().create_timer(2).timeout
		idle_gen()
	
func sadgen():
	var num = [1,2,3] 
	var choice = num[randi() % num.size()]
	anim.play("static")
	await get_tree().create_timer(.2).timeout
	if choice == 1:
		anim.play("empty")
	elif choice == 2:
		anim.play("shock")
	elif choice == 3:
		anim.play("sad")
	await get_tree().create_timer(1).timeout
	idle_gen()
	
func idle_gen():
	anim.play("static")
	await get_tree().create_timer(.2).timeout
	if Global.level <= 9:
		anim.play("talking_idle")
	elif Global.level <= 14:
		anim.play("screaming_idle")
	else:
		anim.play("furious_idle")
