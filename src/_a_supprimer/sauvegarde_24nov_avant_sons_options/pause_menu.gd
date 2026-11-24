extends CanvasLayer

# La scène Options, chargée une seule fois au début.
const SCENE_OPTIONS = preload("res://Menus/options.tscn")


# Au début, le menu pause est caché.
func _ready() -> void:
	visible = false


# Quand on appuie sur P (action "pause"), on met en pause ou on reprend.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		basculer_pause()


# Inverse la pause : si le jeu tourne, il se fige ; s'il est figé, il repart.
func basculer_pause() -> void:
	fermer_options()
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused


func _on_continuer_button_pressed() -> void:
	basculer_pause()


func _on_recommencer_button_pressed() -> void:
	$PauseClic.play()
	await $PauseClic.finished
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	$PauseClic.play()
	await $PauseClic.finished
	get_tree().change_scene_to_file("res://Menus/menu.tscn")


func _on_quitter_button_pressed() -> void:
	$PauseClic.play()
	await $PauseClic.finished
	get_tree().quit()


# OPTIONS : on cache nos boutons et on ajoute la scène Options par-dessus.
func _on_options_button_pressed() -> void:
	var options = SCENE_OPTIONS.instantiate()
	options.name = "Options"
	add_child(options)
	$CenterContainer.visible = false
	$PauseClic.play()
	await $PauseClic.finished
	options.tree_exited.connect(_on_options_fermees)


# Quand les Options disparaissent (bouton RETOUR), on réaffiche nos boutons.
func _on_options_fermees() -> void:
	$CenterContainer.visible = true


# Si on rappuie sur P pendant que les Options sont ouvertes, on les ferme aussi.
func fermer_options() -> void:
	if has_node("Options"):
		get_node("Options").queue_free()
