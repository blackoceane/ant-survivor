extends BaseState
class_name PlayerAttack

@export var player : Player


var direction_tir : Vector2  

# 1 fois en entrant : on s'arrête, on tire, on écoute la fin de l'animation
func enter():
	player.velocity = Vector2.ZERO
	if (player.direction.y < 0):
		player.anim.play("attack_up")
		direction_tir = Vector2.UP
	elif (player.direction.y > 0):
		player.anim.play("attack_down")
		direction_tir = Vector2.DOWN
	elif (player.direction.x > 0):
		player.anim.play("attack_right")
		direction_tir = Vector2.RIGHT
	elif (player.direction.x < 0):
		player.anim.play("attack_left")
		direction_tir = Vector2.LEFT
	else:
		player.anim.play("attack_down")
		direction_tir = Vector2.DOWN

	# Le Muzzle (point de tir) se place devant l'enfant et pointe dans le sens du tir
	var muzzle : Marker2D = player.get_node("Muzzle")
	muzzle.position = Vector2(0, 6) + direction_tir * 14
	muzzle.rotation = direction_tir.angle()

	player.anim.animation_finished.connect(_on_attack_finished)

# 1 fois en sortant : on arrête d'écouter
func exit():
	player.anim.animation_finished.disconnect(_on_attack_finished)


# Appelée par Godot quand l'animation est finie
# (AnimatedSprite2D : pas de paramètre anim_name, contrairement à AnimationPlayer)
func _on_attack_finished() -> void:
	print("Tir !")
	player.shoot()  
	Transitioned.emit(self, "Idle")
