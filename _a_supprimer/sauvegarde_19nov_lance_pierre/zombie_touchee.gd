extends BaseState
class_name ZombieTouchee

@export var fourmi_zombie : FourmiZombie

func enter():
	fourmi_zombie.touchee = false
	fourmi_zombie.velocity = Vector2.ZERO
	if (fourmi_zombie.est_inconsciente()):
		# Plus de 5 graines : elle tombe et ne se relève plus
		fourmi_zombie.anim.play("die")
		fourmi_zombie.anim.animation_finished.connect(_on_mort)   # quand elle a fini de tomber
		fourmi_zombie.remove_from_group("zombies")   # la fourmi amie ne la compte plus comme ennemie
	else:
		fourmi_zombie.anim.play("stunned")
		fourmi_zombie.anim.animation_finished.connect(_on_fini)

func exit():
	if fourmi_zombie.anim.animation_finished.is_connected(_on_fini):
		fourmi_zombie.anim.animation_finished.disconnect(_on_fini)

func update(_delta: float) -> void:
	# Une nouvelle graine pendant qu'elle est étourdie : on recommence l'état
	# (si elle est déjà inconsciente, elle n'est plus dans le groupe "zombies" : on ne fait rien)
	if (fourmi_zombie.touchee and fourmi_zombie.is_in_group("zombies")):
		Transitioned.emit(self, "Touchee")

# Elle n'est plus étourdie : elle repart poursuivre l'enfant
func _on_fini() -> void:
	Transitioned.emit(self, "Poursuivre")

# Elle a fini de tomber : on attend 1 seconde, puis elle disparaît du jeu
func _on_mort() -> void:
	await get_tree().create_timer(1.0).timeout
	fourmi_zombie.queue_free()
