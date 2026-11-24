extends Control

# La scène Options, chargée une seule fois au début.
const SCENE_OPTIONS = preload("res://Menus/options.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$MenuClic.play()
	await $MenuClic.finished
	get_tree().change_scene_to_file("res://main.tscn")


# OPTIONS : on cache nos boutons et on ajoute la scène Options par-dessus.
func _on_options_button_pressed() -> void:
	var options = SCENE_OPTIONS.instantiate()
	add_child(options)
	$CenterContainer.visible = false
	$MenuClic.play()
	await $MenuClic.finished
	options.tree_exited.connect(_on_options_fermees)


# Quand les Options disparaissent (bouton RETOUR), on réaffiche nos boutons.
func _on_options_fermees() -> void:
	$CenterContainer.visible = true
