extends Area2D
class_name Graine

@export var vitesse := 250.0     # pixels par seconde
@export var duree_vie := 1.5     # secondes avant de disparaître

var direction := Vector2.DOWN    # donnée par l'enfant au moment du tir

func _ready() -> void:
	$AnimatedSprite2D.play("vole")

func _physics_process(delta: float) -> void:
	# La graine avance tout droit
	position += direction * vitesse * delta

	# Elle disparaît après un moment pour ne pas rester en mémoire
	duree_vie -= delta
	if duree_vie <= 0:
		queue_free()
