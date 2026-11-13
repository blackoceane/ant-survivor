extends BaseState
class_name ZombieAttackPlayer

@export var fourmi_zombie: FourmiZombie

func enter():
	fourmi_zombie.velocity = Vector2.ZERO
	if (fourmi_zombie.direction.x > 0):
		fourmi_zombie.anim.play("attack_right")
	elif (fourmi_zombie.direction.x < 0):
		fourmi_zombie.anim.play("attack_left")
	else:
		fourmi_zombie.anim.play("attack_down")

