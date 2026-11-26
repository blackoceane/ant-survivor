extends GenericCharacter
class_name FourmiAmi
# un signal annonce un événement, et la méthode qui y est connectée réagit.
signal secourue   # prévient le HUD quand la fourmi commence à suivre l'enfant

@export var player : Player
@export var distance_parler : float = 70.0   # l'enfant doit être aussi près pour que le dialogue commence
@export var distance_suivre : float = 50.0   # elle s'arrête à cette distance de l'enfant
@export var porte : Node2D                   # la porte de la fourmilière (fin du trajet)

var touchee : bool = false        # vrai quand un zombie vient de la mordre
var dialogue_fini : bool = false  # mis à vrai quand le texte est terminé
var est_secourue : bool = false   # demandé si la fourmi est secourue 
func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle_down")
	# Si on ne les a pas choisis dans l'inspecteur, on les cherche dans la scène

	#la fourmi trouve l’enfant toute seule.
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)
	#la fourmi trouve la porte de la fourmilière toute seule.
	if porte == null:
		porte = get_parent().get_node_or_null("PorteFourmiliere")

func _physics_process(_delta: float) -> void:
	move_and_slide()

# Appelée par une fourmi zombie quand elle mord l'amie
func recevoir_morsure() -> void:
	touchee = true

# Combien de zombies sont encore autour d'elle ?
func zombies_proches(rayon: float) -> int:
	var n := 0
	for z in get_tree().get_nodes_in_group("zombies"):
		if global_position.distance_to(z.global_position) < rayon:
			n += 1
	return n

func distance_player() -> float:
	return global_position.distance_to(player.global_position)
