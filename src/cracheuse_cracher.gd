extends BaseState
class_name CracheuseCracher

@export var fourmi : FourmiEnemiCracheuse

func enter():
	fourmi.velocity = Vector2.ZERO
	fourmi.anim.flip_h = fourmi.direction.x > 0   # "attack" regarde vers la gauche
	fourmi.anim.play("attack")                    # la morsure sert d'animation de crachat
	fourmi.anim.animation_finished.connect(_on_fini)

func exit():
	fourmi.anim.animation_finished.disconnect(_on_fini)

func update(_delta: float) -> void:
	if fourmi.touchee:
		Transitioned.emit(self, "Touchee")

# L'animation est finie : au lieu de mordre, elle crache, puis retourne se placer
func _on_fini() -> void:
	fourmi.cracher()
	Transitioned.emit(self, "Poursuivre")   # le nœud « garder ses distances » s'appelle Poursuivre
