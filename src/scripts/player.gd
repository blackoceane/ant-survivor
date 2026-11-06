extends GenericCharacter
class_name Player

@export var bullet_scene : PackedScene
var shoot_interval : float = 1.0 / 3.0  # 3 graines par seconde au maximum
var last_shot : float = 0.0             # Chronomètre pour le tir

func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle_down")

func _physics_process(delta: float) -> void:
	last_shot += delta  # Accumuler le temps écoulé entre les tirs
	move_and_slide()

# Vrai si l'intervalle de tir est respecté
func can_shoot() -> bool:
	return last_shot >= shoot_interval

func shoot() -> void:
	var b : Projectile = bullet_scene.instantiate()  # Instancier la scène de projectile
	get_parent().add_child(b)                        # Ajouter le projectile à la même scène que le joueur
	b.global_transform = $Muzzle.global_transform   # Positionner et orienter le projectile au niveau du Muzzle
	last_shot = 0.0                                  # Réinitialiser le chronomètre après le tir
