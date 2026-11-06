extends GenericCharacter
class_name Player

func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play("idle_down")

func _physics_process(_delta: float) -> void:
	move_and_slide()
