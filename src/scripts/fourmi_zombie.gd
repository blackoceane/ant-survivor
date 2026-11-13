extends GenericCharacter
class_name FourmiZombie

@export var player : Player
@export var fourmi_ami : FourmiAmi
@export var distance_detection : float = 150.0   # l'enfant est repéré s'il est plus près que ça
@export var distance_attaque : float = 55.0      # assez près pour mordre l'enfant (les collisions les gardent à ~47 px)
@export var vitesse : float = 50.0               # vitesse de poursuite
@export var graines_max : int = 5                # nombre de graines avant d'être inconsciente

var touchee : bool = false       # vrai quand une graine vient de la toucher
var graines_recues : int = 0     # combien de graines elle a reçues

func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle")
	# Si on ne les a pas choisis dans l'inspecteur, on les cherche dans la scène (par leur NOM)
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)
	if fourmi_ami == null:
		fourmi_ami = get_tree().current_scene.find_child("fourmi_ami", true, false)

func _physics_process(_delta: float) -> void:
	move_and_slide()

# Appelée par la graine (bullet.gd) quand elle touche la fourmi zombie
func recevoir_graine() -> void:
	graines_recues += 1
	touchee = true

# Vrai quand elle a reçu assez de graines pour tomber
func est_inconsciente() -> bool:
	return graines_recues >= graines_max

# Renvoie la distance entre le zombie et l'enfant (très grande si pas d'enfant dans la scène)
func distance_player() -> float:
	if player == null:
		return INF
	return global_position.distance_to(player.global_position)
