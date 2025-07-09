extends VBoxContainer

const CREDITS_ITEM = preload("res://main_menu/credits/credits_item.tscn")
const TEAM_ITEM = preload("res://main_menu/credits/team_item.tscn")
var max_title_length = 0


func add_rtlabel(text):
	var label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.fit_content = true
	label.text = text
	label.add_theme_color_override("default_color", Color.BLACK)
	add_child(label)


func _ready() -> void:
	print("Parsing credits.json")
	var json_file = FileAccess.open("res://main_menu/credits/credits.json", FileAccess.READ)
	var json_string = json_file.get_as_text()
	json_file.close()
	var credits_data = JSON.parse_string(json_string)
	
	add_rtlabel(credits_data["intro"])
	
	for item_data in credits_data["roles"]:
		var team_item = TEAM_ITEM.instantiate()
		team_item.item_data = item_data
		add_child(team_item)
		if team_item.title_length > max_title_length:
			max_title_length = team_item.title_length	
	
	add_rtlabel(credits_data["thanks"])
	
	for category in range(len(credits_data["categories"])):
		var label = Label.new()
		label.theme_type_variation = "HeaderSmall"
		label.text = credits_data["categories"][category]["title"]
		add_child(label)
		for item_data in credits_data["categories"][category]["items"]:
			var item = CREDITS_ITEM.instantiate()
			item.item_data = item_data
			add_child(item)
			if item.title_length > max_title_length:
				max_title_length = item.title_length
			
	for child in get_children():
		if child is CreditsItem or child is TeamItem:
			child.set_title_width(max_title_length)
