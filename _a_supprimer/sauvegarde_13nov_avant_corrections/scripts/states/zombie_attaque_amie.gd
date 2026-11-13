extends BaseState
class_name ZombieAttaqueAmie


@export var fourmi_zombie : FourmiZombie


func enter():
	print("fourmi_zombie = ", fourmi_zombie)
	fourmi_zombie.velocity = Vector2.ZERO
	var vers_amie = fourmi_zombie.fourmi_ami.global_position - fourmi_zombie.global_position
	fourmi_zombie.anim.flip_h = vers_amie.x > 0
	fourmi_zombie.anim.play("attack")   
