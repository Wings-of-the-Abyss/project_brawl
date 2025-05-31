extends Area2D
class_name Hitbox

@onready var parent_player: CharacterBase
@export var active: bool = false

@export var dmg_mult = 1.0
@export var knb_mult = 1.0
@export var attack_args: Dictionary[CharacterBase.StatusEffects, float] = {}

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	parent_player = get_parent().get_parent()
	collision_mask -= 2**(parent_player.paired_controller+1)
	set_collision_mask_value(1, false)

func _process(_delta: float) -> void:
	$CollisionShape2D.disabled = !active

func _on_body_entered(body) -> void:
	active = false
	attack_effect(body)
	additional_effects(body)

#Overwrite this to add hitbox functionality
func attack_effect(target: CharacterBody2D) -> void:
	pass

func additional_effects(target: CharacterBody2D) -> void:
	pass
