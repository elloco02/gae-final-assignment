extends Control

func _ready() -> void:
	%ResumeButton.pressed.connect(resume)

# resume game
func resume() -> void:
	get_tree().paused = false
	self.visible = not self.visible
