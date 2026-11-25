extends GenericCharacter
class_name Player

signal vie_changee(vie: int)   # prévient le HUD quand la vie change
signal mort
@export var bullet_scene : PackedScene
var shoot_interval : float = 1.0 / 3.0  # 3 graines par seconde au maximum
var last_shot : float = 0.0             # Chronomètre pour le tir
var vie : int = 5                       # nombre de cœurs
var morsures : int = 0                  # morsures reçues depuis le dernier cœur perdu
const MORSURES_PAR_COEUR : int = 5      # il faut 5 morsures pour perdre un cœur

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
	$SonTir.play()                                   # bruit d'élastique du lance-pierre

# Appelée par le lance-pierre bonus quand l'enfant le ramasse : il tire plus souvent
func ameliorer_lance_pierre() -> void:
	shoot_interval = 1.0 / 5.0          # 5 graines par seconde au lieu de 3
	print("Nouveau lance-pierre : l'enfant tire plus vite !")

# Appelée par une fourmi zombie à la fin de sa morsure
func perdre_vie() -> void:
	if vie <= 0:
		return                          # déjà plus de vie : on ne descend pas sous 0
	morsures += 1
	if morsures >= MORSURES_PAR_COEUR:
		morsures = 0                    # on recommence à compter pour le prochain cœur
		vie -= 1
		vie_changee.emit(vie)           # le HUD enlève un cœur
		if vie <= 0:
			$StateMachine.on_child_transition($StateMachine.current_state, "Death") #état Défaite
