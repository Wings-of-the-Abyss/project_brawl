extends CharacterBody2D

@export var paired_controller = -1

var CharacterNode: CharacterBase

const SPEED: float = 600.0
const ACCELERATION: float = 0.6

var direction: Vector2 = Vector2.RIGHT

var dash_duration: float = 0.0
const MAX_dash_duration: float = 0.025
var dashcd: float = 0.0
const MAX_dashcd: float = 2.0

var lock: float= 0.0

func _ready() -> void:
	ControllerHandler.CONTROLLER_NODE_MAP.set(paired_controller, self)
	collision_layer = 2**(paired_controller+1)

func _physics_process(delta: float) -> void:
	if lock > 0: 
		lock -= delta
		velocity = velocity.lerp(Vector2.ZERO, 0.3)
		move_and_slide()
		return
	if dashcd > 0: 
		dashcd -= delta
	if dash_duration > 0:
		dash_duration -= delta
		if dash_duration <= 0:
			dashcd = MAX_dashcd
		move_and_slide()
		return
	if CharacterNode.CurrentStatus.get(CharacterNode.StatusEffects.STUN) > 0:
		move_and_slide()
		return
	var move_vec = Vector2(Input.get_joy_axis(paired_controller, JOY_AXIS_LEFT_X), Input.get_joy_axis(paired_controller, JOY_AXIS_LEFT_Y)).limit_length(1.0)
	if ControllerHandler.KEYBOARD_MODE: move_vec = Input.get_vector("left","right","up","down")
	if move_vec:
		direction = Vector2.from_angle(move_vec.angle())
		velocity = velocity.lerp(move_vec*SPEED*CharacterNode.SPEED, ACCELERATION)
	else:
		velocity = velocity.lerp(Vector2.ZERO, ACCELERATION)
	
	var dash_input = Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_X) or Input.is_action_just_pressed("dash")
	
	if dash_input and dash_duration <= 0 and dashcd <= 0:
		dash_duration = MAX_dash_duration
		velocity = direction * (SPEED*8)
	
	move_and_slide()
