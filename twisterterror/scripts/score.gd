extends RichTextLabel

var default_score = " SCORE : "

func _process(_delta: float) -> void:
	var score = str(default_score, str(Global.score))
	self.text = (score)
