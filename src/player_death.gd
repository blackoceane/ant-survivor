extends BaseState
class_name PlayerDeath

@export var player : Player

func enter():
	player.velocity=Vector2.ZERO
	player.anim.play("death")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
