extends BaseState
class_name ZombieAttaqueAmie


@export var fourmi_zombie : FourmiZombie


func enter():
	fourmi_zombie.velocity = Vector2.ZERO
	fourmi_zombie.anim.play("attack")   

