extends BaseState
class_name PlayerDeath

@export var player : Player

func enter():
	player.velocity=Vector2.ZERO
	player.anim.play("death")
	await player.anim.animation_finished
	player.mort.emit()
