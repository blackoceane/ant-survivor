extends GenericCharacter
class_name FourmiZombie
@export var player :Player 
@export var fourmi_ami : FourmiAmi
@export var distance_suivre : float = 300.0   # l'enfant doit être aussi près pour que le dialogue commence




func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle")
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)
	if fourmi_ami == null:
		fourmi_ami = get_tree().current_scene.find_child("fourmi_ami", true, false)	

func _physics_process(_delta: float) -> void:
	move_and_slide()	

#renvoie la distance entre le zombie et l'enfant
func distance_player() -> float:
	return global_position.distance_to(player.global_position)

  