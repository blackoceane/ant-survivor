extends BaseState
class_name AmiRepos

@export var fourmi : FourmiAmi

func enter():
	fourmi.velocity = Vector2.ZERO
	fourmi.anim.play("idle_up")   # elle regarde la porte de la fourmilière
