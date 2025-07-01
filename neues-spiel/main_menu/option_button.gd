extends OptionButton

var difficulties = [0.75, 1.00, 1.25, 1.5, 2.0]
var difficulty_names = ["Easy", "Normal", "Hard", "Insane", "Nightmare"]

func _ready():
	create_difficulties()
	GameManager.change_difficulty.connect(on_difficulty_changed)
	on_difficulty_changed(GameManager.difficulty)
	self.item_selected.connect(on_item_selected)
	
func on_difficulty_changed(value: float):
	self.selected = difficulties.find(value)
	
func on_item_selected(index: int):
	GameManager.difficulty = difficulties[index]
	
func create_difficulties():
	for difficulty_name in difficulty_names:
		self.add_item(difficulty_name)
