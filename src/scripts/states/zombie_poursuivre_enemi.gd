extends BaseState
class_name PoursuivreEnemi

@export var fourmi_zombie : FourmiZombie

func exit():
	fourmi_zombie.velocity = Vector2.ZERO

func update(_delta: float) -> void:
	if (fourmi_zombie.touchee):
		Transitioned.emit(self, "Touchee")
		return
	if (fourmi_zombie.player == null):
		return

	var dir : Vector2 = fourmi_zombie.player.global_position - fourmi_zombie.global_position
	if (dir.length() < fourmi_zombie.distance_attaque):
		Transitioned.emit(self, "AttackPlayer")
		return

	dir = dir.normalized()
	fourmi_zombie.direction = dir
	fourmi_zombie.velocity = dir * fourmi_zombie.vitesse
	if (abs(dir.x) > abs(dir.y)):
		fourmi_zombie.anim.play("walk_right")
		fourmi_zombie.anim.flip_h = dir.x < 0   # pas de walk_left : on retourne walk_right
	elif (dir.y < 0):
		fourmi_zombie.anim.flip_h = false
		fourmi_zombie.anim.play("walk_up")
	else:
		fourmi_zombie.anim.flip_h = false
		fourmi_zombie.anim.play("walk_down")
