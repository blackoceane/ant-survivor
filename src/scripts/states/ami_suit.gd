extends BaseState
class_name AmiSuit

@export var fourmi : FourmiAmi
var move_speed := 90.0

# Quand la fourmi commence à suivre l'enfant, elle est secourue : on prévient le HUD
func enter():
	fourmi.secourue.emit()

func physics_update(_delta: float) -> void:
	# Arrivée devant la porte : on s'arrête
	if (fourmi.porte and fourmi.global_position.distance_to(fourmi.porte.global_position) < 60.0):
		Transitioned.emit(self, "Repos")
		return
	var dir : Vector2 = fourmi.player.global_position - fourmi.global_position
	if (dir.length() > fourmi.distance_suivre):
		dir = dir.normalized()
		fourmi.direction = dir
		fourmi.velocity = dir * move_speed
		if (abs(dir.x) > abs(dir.y)):
			if (dir.x > 0):
				fourmi.anim.play("walk_right")
			else:
				fourmi.anim.play("walk_left")
		elif (dir.y < 0):
			fourmi.anim.play("walk_up")
		else:
			fourmi.anim.play("walk_down")
	else:
		fourmi.velocity = Vector2.ZERO
		fourmi.anim.play("idle_down")
