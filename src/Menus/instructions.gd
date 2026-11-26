extends Control

# RETOUR : on ferme les Options (le menu qui les a ouvertes réaffiche ses boutons).
func _on_retour_button_pressed() -> void:
	$SonClic.play()
	await $SonClic.finished
	queue_free()

