extends CanvasLayer
var temps: float = 0.0 # le temps qui s ecoule compteur

# Au lancement, on trouve l'enfant et on écoute son signal vie_changee
func _ready() -> void:
	var player = get_tree().current_scene.find_child("Player", true, false)
	if player != null:
		player.vie_changee.connect(maj_vie)
		maj_vie(player.vie)

	# On trouve aussi la fourmi amie et on écoute son signal secourue
	var fourmi = get_tree().current_scene.find_child("fourmi_ami", true, false)
	if fourmi != null:
		fourmi.secourue.connect(maj_mission)


# Met à jour les cœurs selon le nombre de vies restantes.
func maj_vie(vie: int) -> void:
	$MarginContainer/VBoxContainer/LigneVie/LabelCoeur.text = "♥".repeat(vie)

# Appelée quand la fourmi est secourue : la mission change.
func maj_mission() -> void:
	$MarginContainer/VBoxContainer/LabelMission.text = "MISSION : VA DANS LA GROTTE AVEC LA FOURMI"

func _process(delta: float ) -> void:
	temps+=delta
	var secondes : int = int(temps) # parse float en int 
	$MarginContainer/VBoxContainer/LabelTemps.text = "%02d:%02d" % [secondes / 60, secondes % 60]
	
