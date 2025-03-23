extends Node2D


var enemy = preload("res://scenes/enemies/missile.tscn")

func _ready():
	randomize()
	Global.level5.connect(level5)
	Global.level10.connect(level10)
	Global.level15.connect(level15)
	Global.level20.connect(level20)
	Global.level25.connect(level25)
	Global.level30.connect(level30)
	
func _on_missile_spawner_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Player/Path2D/PathFollow2D.progress_ratio = rng.randf_range(0, 1)
	var instance = enemy.instantiate()
	instance.global_position = $Player/Path2D/PathFollow2D.global_position
	add_child(instance)
	
func level5():
	$"missile spawner".start(10)
func level10():
	$"missile spawner".start(8)
func level15():
	$"missile spawner".start(6)
func level20():
	$"missile spawner".start(4)
func level25():
	$"missile spawner".start(2)
func level30():
	$"missile spawner".start(.5)
	
