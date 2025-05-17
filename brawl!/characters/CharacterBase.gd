extends Node2D
class_name  CharacterBase

var HEALTH : float = 50.0
const MAX_HEALTH : float = 50.0
@export_range(0.5, 2.0, 0.1) var ATK: float = 1.0
@export_range(0.5, 2.0, 0.1) var DEF: float = 1.0
@export_range(0.5, 2.0, 0.1) var SPEED: float = 1.0

var parent_player: CharacterBody2D

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

func _physics_process(delta: float) -> void:
	pass

func take_damage(dmg: float, kb: Vector2, additional_args: Dictionary = {}):
	HEALTH -= dmg/DEF
	if HEALTH <= 0.0:
		print("DEAD!")
		return
	parent_player.velocity = kb*300.0
	var stun = 0.05
	if additional_args.has(StatusEffects.STUN):
		stun += additional_args.get(StatusEffects.STUN)
	CurrentStatus.set(StatusEffects.STUN, stun)

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
