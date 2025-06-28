extends Node

var current_scene: Node = null
var fade_layer: CanvasLayer
var transition_time := 0.3

func _ready():
	current_scene = get_tree().current_scene
	var color_rect = init_color_rect()
	init_fade_layer(color_rect)


func init_color_rect() -> ColorRect:
	var color_rect = ColorRect.new()
	color_rect.color = Color.BLACK
	color_rect.size = get_viewport().get_visible_rect().size
	color_rect.name = "Fade"
	color_rect.modulate.a = 0
	return color_rect


func init_fade_layer(color_rect: ColorRect) -> void:
	fade_layer = CanvasLayer.new()
	fade_layer.layer = -100
	fade_layer.add_child(color_rect)
	add_child(fade_layer)
	fade_layer.visible = true


func change_scene_to(scene: PackedScene) -> void:
	fade_out()
	await get_tree().create_timer(transition_time).timeout

	if current_scene:
		current_scene.queue_free()
		if has_node("/root/GameManager"):
			var gameManager = get_node("/root/GameManager")
			for child in gameManager.get_children():
				child.queue_free()
				
	var new_scene = scene.instantiate()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene
	current_scene = new_scene

	fade_in()


# FIXME: possibly dangerous tween code
func fade_out():
	var fade = fade_layer.get_node("Fade")
	fade.modulate.a = 0
	fade_layer.visible = true
	fade.create_tween().tween_property(fade, "modulate:a", 1.0, transition_time)


func fade_in():
	var fade = fade_layer.get_node("Fade")
	fade.create_tween().tween_property(fade, "modulate:a", 0.0, transition_time)
