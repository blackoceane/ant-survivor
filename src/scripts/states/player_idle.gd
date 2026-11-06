extends BaseState
class_name PlayerIdle

@export var player : Player

func manage_input() -> void:
	var dir : Vector2 = Input.get_vector("gauche", "droite", "haut", "bas").normalized()

	if (dir.length() > 0):
		Transitioned.emit(self, "Walk")

	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")

func enter():
	player.velocity = Vector2.ZERO
	if (player.direction.y < 0):
		player.anim.play("idle_up")
	elif (player.direction.y > 0):
		player.anim.play("idle_down")
	elif (player.direction.x > 0):
		player.anim.play("idle_right")
	elif (player.direction.x < 0):
		player.anim.play("idle_left")
	else:
		player.anim.play("idle_down")

func update(_delta: float) -> void:
	manage_input()

func physics_update(_delta: float) -> void:
	pass