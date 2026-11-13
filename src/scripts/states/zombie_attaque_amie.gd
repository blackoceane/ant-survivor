extends BaseState
class_name ZombieAttaqueAmie

@export var fourmi_zombie : FourmiZombie

func enter():
	fourmi_zombie.velocity = Vector2.ZERO
	if fourmi_zombie.fourmi_ami != null:
		var vers_amie = fourmi_zombie.fourmi_ami.global_position - fourmi_zombie.global_position
		fourmi_zombie.anim.flip_h = vers_amie.x > 0   # l'image "attack" regarde vers la gauche
	fourmi_zombie.anim.play("attack")
	fourmi_zombie.anim.animation_finished.connect(_on_morsure_finie)

func exit():
	fourmi_zombie.anim.animation_finished.disconnect(_on_morsure_finie)

func update(_delta: float) -> void:
	if (fourmi_zombie.touchee):
		Transitioned.emit(self, "Touchee")
	elif (fourmi_zombie.distance_player() < fourmi_zombie.distance_detection):
		Transitioned.emit(self, "Poursuivre")

# Une morsure est finie : la fourmi amie est mordue, puis on mord encore
func _on_morsure_finie() -> void:
	if fourmi_zombie.fourmi_ami != null:
		fourmi_zombie.fourmi_ami.recevoir_morsure()
	fourmi_zombie.anim.play("attack")
