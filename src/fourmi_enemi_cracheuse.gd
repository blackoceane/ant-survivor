extends FourmiZombie
class_name FourmiEnemiCracheuse

@export var acide_scene : PackedScene       # glisser acide.tscn ici dans l'Inspecteur
@export var distance_tir : float = 180.0    # plus près que ça : elle crache
@export var distance_trop_pres : float = 100.0   # plus près que ça : elle recule
@export var delai_tir : float = 2.0         # secondes entre deux crachats
var temps_depuis_tir : float = 0.0

func _physics_process(delta: float) -> void:
	# compter le temps 
	temps_depuis_tir+=delta
	move_and_slide()

func cracher() -> void:
	# 1. créer une goutte 
	var a  = acide_scene.instantiate()
	# 2. l'ajouter au parent (2e ligne de shoot())
	get_parent().add_child(a)
	# 3. la placer à MA position
	a.global_position = global_position
	# 4. la tourner vers l'enfant (indice : la fourmi a une variable player)
	a.look_at(player.global_position)
	# 5. remettre le compteur à zéro
	temps_depuis_tir=0