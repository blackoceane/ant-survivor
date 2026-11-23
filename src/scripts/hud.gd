extends CanvasLayer
var temps: float = 0.0 # le temps qui s ecoule compteur

# Au lancement, on trouve l'enfant et on écoute son signal vie_changee
func _ready() -> void:
	var player = get_tree().current_scene.find_child("Player", true, false)
	if player != null:
		player.vie_changee.connect(maj_vie)
		maj_vie(player.vie)


# Met à jour les cœurs selon le nombre de vies restantes.
func maj_vie(vie: int) -> void:
	$MarginContainer/VBoxContainer/LigneVie/LabelCoeur.text = "♥".repeat(vie)

func _process(delta: float ) -> void:
	temps+=delta
	var secondes : int = int(temps) # parse float en int 
	$MarginContainer/VBoxContainer/LabelTemps.text = "%02d:%02d" % [secondes / 60, secondes % 60]
	
