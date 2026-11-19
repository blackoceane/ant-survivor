extends Area2D
class_name LancePierreBonus

# Un nouveau lance-pierre posé par terre : l'enfant le ramasse en marchant dessus

func _ready() -> void:
	# body_entered : signal de l'Area2D, envoyé quand un corps (CharacterBody2D…) entre dans sa zone
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:                   # seul l'enfant peut le ramasser (pas les fourmis)
		body.ameliorer_lance_pierre()
		queue_free()                     # l'objet disparaît : il a été ramassé
