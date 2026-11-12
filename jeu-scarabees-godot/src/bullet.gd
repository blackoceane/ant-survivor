extends Node2D
class_name Projectile

@export var speed : int = 250

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta    # avance vers « l'avant »
	if is_out_of_screen():
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:          # la graine part de la main : on ignore l'enfant
		return
	if body.is_in_group("fourmis") and body.has_method("recevoir_graine"):
		body.recevoir_graine()  #  je suis pas sur regardons
	queue_free()

func is_out_of_screen() -> bool:
	var screen_rect = get_viewport_rect()
	return not screen_rect.has_point(get_global_transform_with_canvas().origin)