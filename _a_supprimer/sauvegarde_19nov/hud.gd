extends CanvasLayer


# TEST (à enlever à l'étape 4) : au lancement, on affiche 3 vies pour vérifier.
func _ready() -> void:
	maj_vie(5)


# Met à jour les cœurs selon le nombre de vies restantes.
func maj_vie(vie: int) -> void:
	$MarginContainer/VBoxContainer/LigneVie/LabelCoeur.text = "♥".repeat(vie)
