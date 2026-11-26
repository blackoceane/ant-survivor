extends Area2D

# Entrée de la grotte : quand l'enfant arrive ici AVEC la fourmi secourue, le niveau 1 est fini.

const SCENE_FIN_NIVEAU = preload("res://Menus/fin_niveau.tscn")   # l'animation de fin (fondu au noir)

@export var fourmi : FourmiAmi   # pour savoir si la fourmi est secourue


# Appelée par le signal body_entered (branché dans l'onglet Signaux) :
# n'importe quel corps qui entre dans la zone (enfant, fourmi amie, zombie...).
func _on_body_entered(body: Node2D) -> void:
	if body is Player and fourmi.est_secourue:
		var fin = SCENE_FIN_NIVEAU.instantiate()   # on fabrique l'écran de fin...
		get_tree().current_scene.add_child(fin)    # ...et on l'ajoute au jeu : son _ready() lance l'animation
	elif body is Player:
		$Message.visible = true                    # « Tu ne peux pas laisser ton amie ! »
		await get_tree().create_timer(2.0).timeout # on attend 2 secondes...
		$Message.visible = false                   # ...puis le message disparaît
