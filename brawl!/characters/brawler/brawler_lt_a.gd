extends "res://characters/brawler/brawler_HitboxCore.gd"

var drag_target
var throw_target

const MAX_drag_duration: float = 0.5
var drag_duration: float = 0.0

func _process(delta: float) -> void:
	$CollisionShape2D.disabled = !active
	if drag_target:
		drag_duration -= delta
		drag_target.velocity = parent_player.parent_movementnode.velocity
		var charnode: CharacterBase = drag_target.CharacterNode
		charnode.CurrentStatus.set(CharacterBase.StatusEffects.STUN, 0.5)
		if drag_duration <= 0:
			throw_target = drag_target
			drag_target = null
	if throw_target:
		var charnode: CharacterBase = throw_target.CharacterNode
		if charnode.CurrentStatus.get(CharacterBase.StatusEffects.STUN) > 0 and throw_target.is_on_wall():
			charnode.take_damage(1.0, throw_target.get_wall_normal(), {CharacterBase.StatusEffects.STUN: 0.5})

func additional_effects(target: CharacterBody2D) -> void:
	drag_target = target
	drag_duration = MAX_drag_duration
