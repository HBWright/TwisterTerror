extends RichTextLabel

var default_level = "LEVEL:"

func _process(_delta: float) -> void:
	var level = str(default_level, str(Global.level))
	self.text = (level)
