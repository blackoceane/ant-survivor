extends Node2D
class_name Acide

@export var speed : int = 150
var temps_de_vie : float = 0

func _physics_process(delta: float) -> void:
	# avancer (comme la graine)
	position += transform.x * speed * delta
	# compter le temps
	temps_de_vie+=delta
	# trop vieux ? on disparaît
	if temps_de_vie >3:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	# une fourmi ? on l'ignore (l'acide sort de sa bouche)
	if body.is_in_group("fourmis"):
		return
	# l'enfant ? il perd de la vie
	if body is Player:
		body.perdre_vie()
	# dans tous les cas (enfant ou mur), la goutte disparaît
	queue_free()
