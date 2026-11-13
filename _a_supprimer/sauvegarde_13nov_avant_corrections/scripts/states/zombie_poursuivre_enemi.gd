extends BaseState
class_name PoursuivreEnemi
var move_speed := 50.0

@export var fourmi_zombie: FourmiZombie


func update(_delta: float) -> void:
	var dir : Vector2 = fourmi_zombie.player.global_position - fourmi_zombie.global_position
	if (dir.length() >fourmi_zombie.distance_suivre):
		dir = dir.normalized()
		fourmi_zombie.direction = dir 
		fourmi_zombie.velocity = dir * move_speed
		if (abs(dir.x) > abs(dir.y)):
			if (dir.x >0):
				fourmi_zombie.anim.play("walk_right")
			else:
				fourmi_zombie.anim.play("walk_left")
		elif (dir.y <0):
			fourmi_zombie.anim.play("walk_up")
		else:
			fourmi_zombie.anim.play("walk_down")
	else:
		fourmi_zombie.velocity = Vector2.ZERO
		fourmi_zombie.anim.play("idle_down")
    
	