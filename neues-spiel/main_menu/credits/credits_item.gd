class_name CreditsItem
extends HBoxContainer

'''
Example data:
{
	"label": "Game Engine",
	"name": "Godot",
	"creator": "the Godot Engine contributors",
	"url": "https://godotengine.org/",
	"license": "MIT",
	"license_url": "https://godotengine.org/license/"
}
'''
@export var item_data: Dictionary

@onready var title_label: RichTextLabel = %TitleLabel
@onready var info_label: RichTextLabel = %InfoLabel
@onready var website_button: LinkButton = %WebsiteButton
@onready var license_button: LinkButton = %LicenseButton

var title_length = 0

func set_title_width(value: int):
	title_label.custom_minimum_size.x = value + 50

func _ready() -> void:
	if not item_data:
		push_error("No data provided, assign a Dictionary to item_data.")
	
	title_label.text = "[b]%s[/b]" % item_data.title
	title_label.add_theme_color_override("default_color", Color.BLACK)
	title_length = title_label.get_content_width()
	var info_text = ""
	if item_data.has("name") and not item_data.name.is_empty():
		info_text += "%s" % item_data.name
	if item_data.has("creator") and not item_data.creator.is_empty():
		info_text += " [i]by %s[/i]" % item_data.creator
	info_label.text = info_text
	info_label.add_theme_color_override("default_color", Color.BLACK)

	# --- Configure Website Button ---
	if item_data.has("url") and not item_data.url.is_empty():
		website_button.text = "Website"
		website_button.uri = item_data.url
		website_button.add_theme_color_override("default_color", Color.BLACK)
		website_button.visible = true
	else:
		website_button.visible = false


	if item_data.has("license_url") and not item_data.license_url.is_empty():
		license_button.text = "License: " + item_data.get("license", "License") # Get license name or default
		license_button.add_theme_color_override("default_color", Color.BLACK)
		license_button.uri = item_data["license_url"]
		license_button.visible = true
	else:
		license_button.visible = false

	if website_button.visible:
		website_button.pressed.connect(_on_button_pressed)

	if license_button.visible:
		license_button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
