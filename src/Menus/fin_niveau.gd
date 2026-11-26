extends CanvasLayer

# Animation de fin du niveau 1 : l'écran devient noir petit à petit,
# « NIVEAU 1 TERMINÉ ! » apparaît, puis on passe à la scène de la grotte (niveau 2).
# Cette scène est ajoutée par la porte de la grotte (porte_grotte.gd).


func _ready() -> void:
	get_tree().paused = true                    # tout se fige (process_mode Always : nous, on continue)
	$FinClic.play()                             # petit son de victoire

	var tween = create_tween()                  # un Tween fait varier une propriété petit à petit
	tween.tween_property($Noir, "modulate:a", 1.0, 1.0)   # le noir : transparent → opaque en 1 s
	tween.tween_property($Label, "modulate:a", 1.0, 0.5)  # puis le texte apparaît en 0,5 s
	await tween.finished                        # on attend la fin des deux animations

	await get_tree().create_timer(1.5).timeout  # on laisse le texte affiché 1,5 s
	get_tree().paused = false                   # sinon la grotte commencerait figée
	get_tree().change_scene_to_file("res://niveaux/grotte.tscn")
