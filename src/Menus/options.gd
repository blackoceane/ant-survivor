extends Control
const SCENE_INSTRUCTIONS = preload("res://Menus/instructions.tscn")

# À l'ouverture des Options, on remet les curseurs et la case MUET
# comme le vrai son, qui est rangé dans l'AudioServer (lui n'est jamais détruit).
# « _no_signal » : on bouge le curseur SANS déclencher value_changed / toggled.
func _ready() -> void:
	$CenterContainer/VBoxContainer/LigneMusique/SliderMusique.set_value_no_signal(volume_du_bus("Musique"))
	$CenterContainer/VBoxContainer/LigneEffets/SliderEffets.set_value_no_signal(volume_du_bus("Effets"))
	$CenterContainer/VBoxContainer/MuetCheck.set_pressed_no_signal(AudioServer.is_bus_mute(0))


# Donne le volume d'un bus en pourcentage (0 à 100), pour placer le curseur.
# C'est l'inverse de ce qu'on fait dans les curseurs : décibels -> 0..1 -> 0..100.
func volume_du_bus(nom: String) -> float:
	var bus = AudioServer.get_bus_index(nom)
	return db_to_linear(AudioServer.get_bus_volume_db(bus)) * 100.0


# RETOUR : on ferme les Options (le menu qui les a ouvertes réaffiche ses boutons).
func _on_retour_button_pressed() -> void:
	$SonClic.play()
	await $SonClic.finished
	queue_free()



func _on_muet_check_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)


func _on_slider_effets_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Effets")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))

func _on_slider_musique_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Musique")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))


func _on_instructions_button_pressed() -> void:
	var instructions = SCENE_INSTRUCTIONS.instantiate()
	add_child(instructions)
	$CenterContainer.visible = false
	$SonClic.play()
	await $SonClic.finished
	instructions.tree_exited.connect(_on_instructions_fermees)


# Quand les Options disparaissent (bouton RETOUR), on réaffiche nos boutons.
func _on_instructions_fermees() -> void:
	$CenterContainer.visible = true	
