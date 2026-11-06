extends BaseState
class_name PlayerWalk

@export var player : Player

@export var move_speed := 120.0

func manage_input() -> Vector2:
	var dir : Vector2 = Input.get_vector("gauche", "droite", "haut", "bas").normalized()

	return dir

func update(_delta : float) -> void:

	var dir := manage_input()

	if dir.length() > 0 :
		if Input.is_action_just_pressed("attack") and not player.is_attacking:
			Transitioned.emit(self, "Attack")
		else:
			player.velocity = dir * move_speed
			player.direction = dir
	else :
		player.velocity = player.velocity.move_toward(Vector2.ZERO, 10)

	if (player.velocity.length() == 0) :
		Transitioned.emit(self, "idle")


func physics_update(_delta: float) -> void:

	if (player.velocity.length() > 0) :
		if (player.velocity.x > 0 or player.velocity.x < 0) :
			if (player.velocity.x > 0) :
				player.anim.play("walk_right")
			elif (player.velocity.x < 0) :
				player.anim.play("walk_left")
		elif (player.velocity.y < 0) :
			player.anim.play("walk_up")
		elif (player.velocity.y > 0) :
			player.anim.play("walk_down")