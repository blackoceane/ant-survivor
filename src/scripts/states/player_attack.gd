extends BaseState
class_name PlayerAttack

@export var player : Player

const GRAINE = preload("res://graine.tscn")

var direction_tir : Vector2   # le sens de l'animation choisie (haut, bas, gauche ou droite)

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
	player.anim.animation_finished.connect(_on_attack_finished)

# 1 fois en sortant : on arrête d'écouter
func exit():
	player.anim.animation_finished.disconnect(_on_attack_finished)

# Fait apparaître une graine devant l'enfant
func tirer_graine():
	var graine = GRAINE.instantiate()
	graine.direction = direction_tir
	# d'abord l'ajouter à la scène, ENSUITE la placer (sinon le décalage du parent compte deux fois)
	player.get_parent().add_child(graine)
	# part de la main : un peu devant l'enfant, à hauteur de la poitrine
	graine.global_position = player.global_position + Vector2(0, 6) + direction_tir * 14

# Appelée par Godot quand l'animation est finie
# (AnimatedSprite2D : pas de paramètre anim_name, contrairement à AnimationPlayer)
func _on_attack_finished() -> void:
	print("Tir !")
	tirer_graine()
	Transitioned.emit(self, "Idle")
