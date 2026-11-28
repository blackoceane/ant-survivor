extends Node2D

# NIVEAU 2 : la grotte des fourmis.
# Les galeries sont créées par une MARCHE ALÉATOIRE (algorithme 1) :
# un « creuseur » part du centre et fait des pas au hasard (haut, bas, gauche, droite).
# Chaque case où il passe devient du SOL. Les cases autour du sol deviennent des MURS.
# À chaque partie (et à chaque RECOMMENCER), la grotte est différente.

@export var nb_pas : int = 700          # nombre de pas du creuseur : plus il y en a, plus la grotte est grande
@export var taille_max : int = 25       # le creuseur ne sort pas d'un carré de -25 à 25 cases
@export var chance_obstacle : float = 0.25 # 25 % des cases « dégagées » reçoivent un accessoire
@export var marge : int = 6             # épaisseur de terre autour de la grotte (comme le sol du jardin, tout l'écran est rempli)
@export var nb_cracheuses : int = 6      # fourmis qui crachent de l'acide de loin
@export var nb_pas_cracheuses : int = 8 # fourmis zombies qui mordent
const SCENE_PAS_CRACHEUSE = preload("res://fourmi_enemi.tscn")
const SCENE_CRACHEUSE = preload("res://fourmi_enemi_cracheuse.tscn")
const DIRECTIONS = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
const SOURCE = 0   # numéro de l'image de tuiles dans le TileSet

# Les accessoires : des scènes d'obstacles, comme dans le jardin (StaticBody2D + Sprite2D + collision)
const OBSTACLES = [
	preload("res://obstacles/grotte/oeufs.tscn"),
	preload("res://obstacles/grotte/cocons.tscn"),
	preload("res://obstacles/grotte/graines.tscn"),
	preload("res://obstacles/grotte/feuille.tscn"),
	preload("res://obstacles/grotte/champignon_parasite.tscn"),
	preload("res://obstacles/grotte/spores.tscn"),
	preload("res://obstacles/grotte/champignons_lumineux.tscn"),
	preload("res://obstacles/grotte/racines.tscn"),
	preload("res://obstacles/grotte/pierre.tscn"),
	preload("res://obstacles/grotte/goutte.tscn"),
]
const SCENE_ENTREE_REINE = preload("res://obstacles/grotte/entree_reine.tscn")

@onready var sol : TileMapLayer = $Sol

var cases_sol : Dictionary = {}   # toutes les cases de sol : cases_sol[Vector2i(x, y)] = true
var case_entree : Vector2i        # où se trouve l'entrée de la salle de la reine


func _ready() -> void:
	generer_galeries()
	dessiner_sol()
	dessiner_murs()
	placer_joueur()
	placer_entree_reine()
	placer_obstacles()
	placer_fourmis(SCENE_PAS_CRACHEUSE, nb_pas_cracheuses)
	placer_fourmis(SCENE_CRACHEUSE, nb_cracheuses)
	$HUD/MarginContainer/VBoxContainer/LabelMission.text = "MISSION : EXPLORE LA FOURMILIÈRE"
	cacher_titre()


# ALGORITHME 1 — la marche aléatoire.
func generer_galeries() -> void:
	var pos := Vector2i.ZERO                     # le creuseur part du centre
	cases_sol[pos] = true
	for _i in nb_pas:
		var dir : Vector2i = DIRECTIONS.pick_random()   # une direction au hasard
		var suivante : Vector2i = pos + dir
		# on n'avance que si on reste dans le carré permis
		if abs(suivante.x) <= taille_max and abs(suivante.y) <= taille_max:
			pos = suivante
			cases_sol[pos] = true                # cette case devient du sol


# Chaque case de sol reçoit une des 3 tuiles de sol (ligne 0 de l'image), au hasard.
func dessiner_sol() -> void:
	for case in cases_sol:
		sol.set_cell(case, SOURCE, Vector2i(randi() % 3, 0))


# Les murs : TOUTES les autres cases du rectangle (la grotte + une marge tout autour),
# pour que l'écran soit rempli de terre, comme le sol du jardin.
# Ligne 1 de l'image : 16 tuiles de mur. Le numéro (0 à 15) dit de quels côtés il y a du sol :
# haut = 1, droite = 2, bas = 4, gauche = 8 (on additionne). Ex. : sol en haut et à gauche → 1 + 8 = 9.
# Comme ça, la bordure de terre émiettée est toujours du côté du sol.
func dessiner_murs() -> void:
	var limite : int = taille_max + marge
	for x in range(-limite, limite + 1):
		for y in range(-limite, limite + 1):
			var mur := Vector2i(x, y)
			if not cases_sol.has(mur):
				dessiner_un_mur(mur)


# Choisit la bonne tuile de mur selon ses 4 voisins, puis la pose.
func dessiner_un_mur(mur : Vector2i) -> void:
	var numero := 0
	if cases_sol.has(mur + Vector2i.UP):
		numero += 1
	if cases_sol.has(mur + Vector2i.RIGHT):
		numero += 2
	if cases_sol.has(mur + Vector2i.DOWN):
		numero += 4
	if cases_sol.has(mur + Vector2i.LEFT):
		numero += 8
	sol.set_cell(mur, SOURCE, Vector2i(numero, 1))   # les tuiles de mur ont une collision


# L'enfant commence au centre, là où le creuseur est parti.
func placer_joueur() -> void:
	$Player.global_position = sol.to_global(sol.map_to_local(Vector2i.ZERO))


# L'entrée de la salle de la reine est posée sur la case de sol la plus LOIN du départ.
func placer_entree_reine() -> void:
	var plus_loin := Vector2i.ZERO
	for case in cases_sol:
		if Vector2(case).length() > Vector2(plus_loin).length():
			plus_loin = case
	var entree = SCENE_ENTREE_REINE.instantiate()
	entree.global_position = sol.to_global(sol.map_to_local(plus_loin)) + Vector2(0, 20)
	$Obstacles.add_child(entree)
	case_entree = plus_loin


# Des accessoires au hasard, comme les obstacles du jardin.
# On les pose seulement sur les cases « dégagées » (du sol tout autour, dans les 8 directions) :
# comme ça, un obstacle ne bouche jamais un couloir étroit.
func placer_obstacles() -> void:
	for case in cases_sol:
		if case.length() > 2 and case != case_entree and est_degagee(case) and randf() < chance_obstacle:
			var obstacle = OBSTACLES.pick_random().instantiate()
			obstacle.global_position = sol.to_global(sol.map_to_local(case)) + Vector2(randf_range(-10, 10), randf_range(0, 16))
			$Obstacles.add_child(obstacle)


# Vrai si les 8 cases autour sont toutes du sol.
func est_degagee(case : Vector2i) -> bool:
	for dx in range(-1, 2):
		for dy in range(-1, 2):
			if not cases_sol.has(case + Vector2i(dx, dy)):
				return false
	return true


# Le titre « NIVEAU 2 » reste 2 secondes, puis disparaît en fondu (comme la fin du niveau 1).
func cacher_titre() -> void:
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_property($Titre/Label, "modulate:a", 0.0, 1.0)

# Pose nb_cracheuses fourmis cracheuses sur des cases de sol au hasard, loin du départ.
# Pose « nombre » fourmis de la scène « scene » sur des cases de sol au hasard, loin du départ.
# On l'appelle deux fois dans _ready() : une fois pour les zombies, une fois pour les cracheuses.
func placer_fourmis(scene : PackedScene, nombre : int) -> void:
	var cases : Array = cases_sol.keys()     # la liste de toutes les cases de sol
	var placees : int = 0                    # combien on en a déjà posé
	while placees < nombre:
		var case : Vector2i = cases.pick_random()   # une case de sol au hasard
		if Vector2(case).length() > 6:              # au moins 6 cases loin du départ
			var f = scene.instantiate()
			f.global_position = sol.to_global(sol.map_to_local(case))
			$Enemies.add_child(f)
			placees += 1                            # une de plus !
