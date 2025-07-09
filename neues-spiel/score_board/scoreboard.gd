extends Control

@onready var title_label = $MarginContainer/VBoxContainer/HBoxContainer/Title
@onready var vertical_container = $MarginContainer/VBoxContainer
@onready var main_menu_scene: PackedScene = preload("res://main_menu/main_menu.tscn")
const HEADER_FONT_SIZE = 30
const ENTRY_FONT_SIZE = 30
const HEADER_COLOR = Color.SADDLE_BROWN
const ENTRY_COLOR = Color.BLACK
const RANK_MIN_WIDTH = 80
const NAME_MIN_WIDTH = 300
const SCORE_MIN_WIDTH = 120
var highscores_container: VBoxContainer
var scroll_container: ScrollContainer
var no_scores_label: Label


func _ready():
	_setup_title_style()
	_create_ui()
	_display_highscores()


func _create_ui():
	_create_header()
	# Scrollbar
	scroll_container = ScrollContainer.new()
	scroll_container.name = "ScrollContainer"
	scroll_container.size_flags_horizontal = SIZE_EXPAND_FILL
	scroll_container.size_flags_vertical = SIZE_EXPAND_FILL
	# Highscores
	highscores_container = VBoxContainer.new()
	highscores_container.name = "Highscores"
	highscores_container.size_flags_horizontal = SIZE_EXPAND_FILL
	scroll_container.add_child(highscores_container)
	vertical_container.add_child(scroll_container)


func _display_highscores():
	# Delete old entries
	for child in highscores_container.get_children():
		if child.name != "Header":
			child.queue_free()
	var highscores = ScoreManager.load_highscores()
	for i in range(highscores.size()):
		var entry = highscores[i]
		print(str(i) + " " + entry["username"] + " " + str(entry["score"]))
		_create_score_entry(i + 1, entry["username"], entry["score"])


func _create_header():
	var header_row = HBoxContainer.new()
	header_row.name = "Header"
	header_row.size_flags_horizontal = SIZE_EXPAND_FILL
	_create_label("Rank", HEADER_FONT_SIZE, HEADER_COLOR, RANK_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, header_row)
	_create_label("Username", HEADER_FONT_SIZE, HEADER_COLOR, NAME_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, header_row)
	_create_label("Score", HEADER_FONT_SIZE, HEADER_COLOR, SCORE_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, header_row)
	vertical_container.add_child(header_row)


func _create_score_entry(rank: int, username: String, score: float):
	var score_row = HBoxContainer.new()
	score_row.size_flags_horizontal = SIZE_EXPAND_FILL
	highscores_container.add_child(score_row)
	_create_label("#" + str(rank), ENTRY_FONT_SIZE, ENTRY_COLOR, RANK_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, score_row)
	_create_label(username, ENTRY_FONT_SIZE, ENTRY_COLOR, NAME_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, score_row)
	_create_label(str(score), ENTRY_FONT_SIZE, ENTRY_COLOR, SCORE_MIN_WIDTH, HORIZONTAL_ALIGNMENT_LEFT, score_row)


func _create_label(text: String, font_size: int, color: Color, min_width: int, alignment: HorizontalAlignment, parent: Node):
	var label = Label.new()
	label.text = text
	label.size_flags_horizontal = SIZE_EXPAND
	label.horizontal_alignment = alignment
	label.custom_minimum_size = Vector2(min_width, 0)
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	parent.add_child(label)


func _setup_title_style():
	title_label.text = "HIGHSCORES"
	title_label.size_flags_horizontal = SIZE_EXPAND_FILL
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 30)


func _on_main_menu_button_pressed() -> void:
	AudioManager.create_2d_audio_middle(SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	SceneManager.change_scene_to(main_menu_scene)
