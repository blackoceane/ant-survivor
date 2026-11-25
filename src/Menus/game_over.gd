extends CanvasLayer

# Écran GAME OVER : il apparaît quand l'enfant a fini son animation de mort.
# Le signal "mort" de l'enfant est branché sur afficher() dans main.tscn (onglet Signaux).


# Au début, l'écran est caché.
func _ready() -> void:
	visible = false


# Appelée par le signal "mort" de l'enfant.
func afficher() -> void:
	visible = true
	get_tree().paused = true    # tout le jeu se fige (les zombies arrêtent de bouger)
	$CenterContainer/VBoxContainer/RecommencerButton.grab_focus()   # pour jouer au clavier / à la manette


func _on_recommencer_button_pressed() -> void:
	$GameOverClic.play()
	await $GameOverClic.finished
	get_tree().paused = false   # sinon la nouvelle partie commencerait figée
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	$GameOverClic.play()
	await $GameOverClic.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/menu.tscn")


func _on_quitter_button_pressed() -> void:
	$GameOverClic.play()
	await $GameOverClic.finished
	get_tree().quit()
