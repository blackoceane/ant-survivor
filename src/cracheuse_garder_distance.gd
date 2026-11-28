extends BaseState
class_name CracheuseGarderDistance

@export var fourmi : FourmiEnemiCracheuse

func exit():
	fourmi.velocity = Vector2.ZERO

func update(_delta: float) -> void:
	# 1. Touchée par une graine ? 
	if (fourmi.touchee):
		Transitioned.emit(self, "Touchee")
		return
	if fourmi.player == null:
		return

	# 2. La flèche de la fourmi vers l'enfant (même calcul que dans Poursuivre)
	var dir : Vector2 = fourmi.player.global_position - fourmi.global_position
	var distance : float = dir.length()   # la longueur de la flèche = la distance
	dir = dir.normalized()                # on garde juste la direction
	fourmi.direction = dir

	# 3. Trop loin : elle ne l'a pas vu, elle attend
	if distance > fourmi.distance_detection:
		fourmi.velocity = Vector2.ZERO
		fourmi.anim.play("idle")
		return

	# 4. Assez près ET le compteur a dépassé le délai : on crache !
	if distance < fourmi.distance_tir and fourmi.temps_depuis_tir >= fourmi.delai_tir:
		Transitioned.emit(self, "Cracher")
		return

	# 5. Se placer : trop loin → avancer, trop près → reculer, sinon → s'arrêter
	if distance > fourmi.distance_tir:
		fourmi.velocity =   dir*fourmi.vitesse       # comme dans Poursuivre
	elif distance < fourmi.distance_trop_pres:
		fourmi.velocity = -dir*fourmi.vitesse          # le contraire d'avancer (un seul signe en plus)
	else:
		fourmi.velocity = Vector2.ZERO

	# 6. Animations 
	if (abs(dir.x) > abs(dir.y)):
		fourmi.anim.play("walk_right")
		fourmi.anim.flip_h = dir.x < 0   # pas de walk_left : on retourne walk_right
	elif (dir.y < 0):
		fourmi.anim.flip_h = false
		fourmi.anim.play("walk_up")
	else:
		fourmi.anim.flip_h = false
		fourmi.anim.play("walk_down")
