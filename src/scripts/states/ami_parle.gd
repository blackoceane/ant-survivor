extends BaseState
class_name AmiParle

@export var fourmi : FourmiAmi

func enter():
	fourmi.velocity = Vector2.ZERO
	fourmi.anim.play("idle_down")   # pendant le dialogue elle est en idle

func update(_delta: float) -> void:
	# Le dialogue démarre tout seul quand l'enfant est proche (pas de bouton)
	if (fourmi.distance_player() < fourmi.distance_parler and not fourmi.dialogue_fini):
		print("Fourmi amie : Merci ! Prends ces 3 graines pour soigner la reine.")
		fourmi.dialogue_fini = true   # sera remplacé par la vraie boîte de dialogue
	if (fourmi.dialogue_fini):
		Transitioned.emit(self, "Suit")
