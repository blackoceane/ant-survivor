extends BaseState
class_name ZombieAttackPlayer

@export var fourmi_zombie : FourmiZombie

func enter():
	fourmi_zombie.velocity = Vector2.ZERO
	fourmi_zombie.anim.flip_h = fourmi_zombie.direction.x > 0   # "attack" regarde vers la gauche
	fourmi_zombie.anim.play("attack")
	fourmi_zombie.anim.animation_finished.connect(_on_fini)

func exit():
	fourmi_zombie.anim.animation_finished.disconnect(_on_fini)

func update(_delta: float) -> void:
	if (fourmi_zombie.touchee):
		Transitioned.emit(self, "Touchee")

# La morsure est finie : on recommence à poursuivre l'enfant
func _on_fini() -> void:
	if fourmi_zombie.player != null:
		fourmi_zombie.player.perdre_vie()   # 5 morsures = 1 cœur perdu
	Transitioned.emit(self, "Poursuivre")
