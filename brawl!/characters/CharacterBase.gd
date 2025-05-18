extends Node2D
class_name  CharacterBase

var paired_controller: int = -1

var HEALTH : float = 50.0
const MAX_HEALTH : float = 50.0
@export_range(0.5, 2.0, 0.1) var ATK: float = 1.0
@export_range(0.5, 2.0, 0.1) var DEF: float = 1.0
@export_range(0.5, 2.0, 0.1) var SPEED: float = 1.0

var parent_player: CharacterBody2D
var dir: Vector2 = Vector2.RIGHT
var attack_cooldown: float = 0.0

var block_cooldown: float = 0.0
const MAX_block_cooldown: float = 5.0
var block_duration: float = 0.0
const MAX_block_duration: float = 0.1

enum StatusEffects {
	STUN,
	POISON,
	MARK,
}
var CurrentStatus = {
	StatusEffects.STUN: 0.0,
	StatusEffects.POISON: 0.0,
	StatusEffects.MARK: 0.0,
}

func _ready() -> void:
	parent_player = get_parent()
	parent_player.CharacterNode = self
	paired_controller = parent_player.paired_controller

func _physics_process(delta: float) -> void:
	rotation = parent_player.direction.angle()
	for eff in CurrentStatus.keys():
		if CurrentStatus.get(eff) > 0:
			CurrentStatus.set(eff, CurrentStatus.get(eff)-delta)
	if attack_cooldown <= 0:
		if Input.get_joy_axis(paired_controller, JOY_AXIS_TRIGGER_RIGHT):
			if Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_A):
				atk_RT_A()
			elif Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_B):
				atk_RT_B()
		elif Input.get_joy_axis(paired_controller, JOY_AXIS_TRIGGER_LEFT):
			if Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_A):
				atk_LT_A()
			elif Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_B):
				atk_LT_B() 
		else:
			if Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_A):
				atk_A()
			elif Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_B):
				atk_B()
	if block_cooldown <= 0.0 and Input.is_joy_button_pressed(paired_controller, JOY_BUTTON_Y):
		counter_Y()
	
	if block_cooldown > 0:
		block_cooldown -= delta
	if block_duration > 0:
		block_duration -= delta

func take_damage(dmg: float, kb: Vector2, additional_args: Dictionary = {}):
	HEALTH -= dmg/DEF
	if HEALTH <= 0.0:
		print("DEAD!")
		return
	parent_player.velocity = kb*300.0
	for a in additional_args.keys():
		CurrentStatus.set(a, CurrentStatus.get(a)+additional_args.get(a))
	CurrentStatus.set(StatusEffects.STUN, CurrentStatus.get(StatusEffects.STUN)+0.05)

#Override these in extending nodes to make behavior
func atk_A() -> void:
	pass
func atk_B() -> void:
	pass
func atk_RT_A() -> void:
	pass
func atk_RT_B() -> void:
	pass
func atk_LT_A() -> void:
	pass
func atk_LT_B() -> void:
	pass

func counter_Y() -> void:
	block_duration = MAX_block_duration
	block_cooldown = MAX_block_cooldown
func counter_success() -> void: 
	pass
