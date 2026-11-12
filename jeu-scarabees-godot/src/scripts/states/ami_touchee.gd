extends BaseState
class_name AmiTouchee

@export var fourmi : FourmiAmi

func enter():
	fourmi.touchee = false
	fourmi.velocity = Vector2.ZERO
	fourmi.anim.play("hurt")
	fourmi.anim.animation_finished.connect(_on_fini)

func exit():
	fourmi.anim.animation_finished.disconnect(_on_fini)

func _on_fini() -> void:
	Transitioned.emit(self, "Combat")
