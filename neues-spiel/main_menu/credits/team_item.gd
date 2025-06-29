class_name TeamItem
extends HBoxContainer

'''
Example data:
		{
			"role": "Game Design",
			"creators": [
				{
					"name": "...kaiec.",
					"url": "https://kaiec.itch.io/",
					"comment": "Lonely Hero"
				}
			]
		}
'''
@export var item_data: Dictionary

@onready var title_label: RichTextLabel = %TitleLabel
@onready var people_container: VBoxContainer = %PeopleContainer

var title_length = 0

func set_title_width(value: int):
	title_label.custom_minimum_size.x = value + 50

func _ready() -> void:
	if not item_data:
		push_error("No data provided, assign a Dictionary to item_data.")
	
	title_label.text = "[b]%s[/b]" % item_data.role
	title_length = title_label.get_content_width()
	for creator in item_data["creators"]:
		var info_text = ""
		if creator.has("url") and not creator.url.is_empty():
			info_text += "[url=%s]" % creator.url
		if creator.has("name") and not creator.name.is_empty():
			info_text += "%s" % creator.name
		if creator.has("url") and not creator.url.is_empty():
			info_text += "[/url]"
		if creator.has("comment") and not creator.comment.is_empty():
			info_text += " (%s)" % creator.comment
		var label = RichTextLabel.new()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.bbcode_enabled = true
		label.fit_content = true
		label.text = info_text
		label.meta_clicked.connect(func(meta): OS.shell_open(meta))
		people_container.add_child(label)
