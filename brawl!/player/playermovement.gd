extends CharacterBody2D

@export var paired_controller = -1

var CharacterNode: CharacterBase

const SPEED: float = 400.0
const ACCELERATION: float = 0.6

func _physics_process(delta: float) -> void:
	if CharacterNode.CurrentStatus.get(CharacterNode.StatusEffects.STUN) > 0:
		move_and_slide()
		return
	var move_vec = Vector2(Input.get_joy_axis(paired_controller, JOY_AXIS_LEFT_X), Input.get_joy_axis(paired_controller, JOY_AXIS_LEFT_Y))
	if move_vec:
		velocity = velocity.lerp(move_vec*SPEED, ACCELERATION)
	else:
		velocity = velocity.lerp(Vector2.ZERO, ACCELERATION)
	move_and_slide()
