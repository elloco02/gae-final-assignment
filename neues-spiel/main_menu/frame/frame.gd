class_name Frame
extends ColorRect

@onready var content_container: ScrollContainer = %ContentContainer
@onready var frame_label: Label = %FrameLabel

@export var title: String = ""

func _ready() -> void:
	print("Printing frame")
	if frame_label:
		frame_label.text = title
	if get_child_count() > 1:
		var content = get_child(1)
		remove_child(content)
		content_container.add_child(content)
		if "close_frame_requested" in content:
			content.close_frame_requested.connect(func(): hide())
	else:
		push_warning("No child node found to be displayed in this frame.")

func _on_close_button_pressed() -> void:
	hide()
