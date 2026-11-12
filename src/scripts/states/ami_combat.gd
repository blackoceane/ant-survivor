extends BaseState
class_name AmiCombat

@export var fourmi : FourmiAmi

func enter():
	fourmi.velocity = Vector2.ZERO
	if (fourmi.direction.x > 0):
		fourmi.anim.play("attack_right")
	elif (fourmi.direction.x < 0):
		fourmi.anim.play("attack_left")
	else:
		fourmi.anim.play("attack_down")

func update(_delta: float) -> void:
	if (fourmi.touchee):
		Transitioned.emit(self, "Touchee")
	elif (fourmi.zombies_proches(250.0) == 0):
		Transitioned.emit(self, "Parle")
