extends RichTextLabel

var default = "-"

func _process(_delta: float) -> void:
	var damage = str(default, str(Global.spin_damage))
	self.text = (damage)
