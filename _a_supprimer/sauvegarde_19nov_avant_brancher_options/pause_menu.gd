extends CanvasLayer


# Au début, le menu pause est caché.
func _ready() -> void:
	visible = false


# Quand on appuie sur P (action "pause"), on met en pause ou on reprend.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		basculer_pause()


# Inverse la pause : si le jeu tourne, il se fige ; s'il est figé, il repart.
func basculer_pause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused


func _on_continuer_button_pressed() -> void:
	basculer_pause()


func _on_recommencer_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/menu.tscn")


func _on_quitter_button_pressed() -> void:
	get_tree().quit()
