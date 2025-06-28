class_name FrameButton
extends Button

@export var frame : Frame

func _ready() -> void:
	# frame.show()
	frame.hide()

func _on_pressed() -> void:
	print("Pressed")
	frame.show()
