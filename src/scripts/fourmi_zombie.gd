extends GenericCharacter
class_name FourmiZombi
@export var player :Player 
@export var fourmi_ami : FourmiAmi



func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle")
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)
	if fourmi_ami == null:
		fourmi_ami = get_tree().current_scene.find_child("FourmiAmi", true, false)	

func _physics_process(_delta: float) -> void:
	move_and_slide()	

#renvoie la distance entre le zombie et l'enfant
func distance_player() -> float:
	return global_position.distance_to(player.global_position)

  