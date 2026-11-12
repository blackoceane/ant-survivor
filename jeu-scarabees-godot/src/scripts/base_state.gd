extends Node
class_name BaseState

@warning_ignore("unused_signal")   # le signal est émis par les états enfants
signal Transitioned

# Le _ devant un paramètre dit à Godot : « c'est normal qu'il ne soit pas utilisé ici »
func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass
