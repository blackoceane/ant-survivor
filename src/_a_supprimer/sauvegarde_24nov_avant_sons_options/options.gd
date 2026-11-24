extends Control


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
