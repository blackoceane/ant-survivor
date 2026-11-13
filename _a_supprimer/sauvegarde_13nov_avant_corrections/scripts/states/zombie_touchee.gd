extends BaseState
class_name ZombieTouchee
var move_speed := 50.0
var graine_recu := 0.0
@export var fourmi_zombie: FourmiZombie

func enter():
	var dir_graine : Vector2 = fourmi_zombie.player.recevoir_graine().b.global_position - fourmi_zombie.global_position
	if (dir_graine.length() < fourmi_zombie.distance_touche):
		print("Fourmi zombie a reçu la graine")
		fourmi_zombie.velocity = Vector2.ZERO
		fourmi_zombie.anim.play("stunned")
		fourmi_zombie.anim.animation_finished.connect(_on_fini)
		graine_recu += 1.0
	if (graine_recu >= 5.0):
		fourmi_zombie.anim.play("die")
		fourmi_zombie.anim.animation_finished.connect(_on_die)

func exit():
	fourmi_zombie.anim.animation_finished.disconnect(_on_fini)
	fourmi_zombie.anim.animation_finished.disconnect(_on_die)


func _on_fini() -> void:
	Transitioned.emit(self, "attack")
   

func _on_die() -> void:
	Transitioned.emit(self, "die")   