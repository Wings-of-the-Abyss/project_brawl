extends Hitbox

#Variables here

#Overwrite this with desired behavior. Template prebuilt with a basic attack without effects
func attack_effect(target: CharacterBody2D) -> void:
	var target_characternode: CharacterBase = target.CharacterNode
	if target_characternode.block_duration > 0.0:
		target_characternode.counter_success()
		target_characternode.block_duration = 0.0
		parent_player.parent_movementnode.velocity = target.global_position.direction_to(global_position)*400
		parent_player.CurrentStatus.set(parent_player.StatusEffects.STUN, 0.2)
		return
	
	var damage = parent_player.ATK*dmg_mult
	if target_characternode.CurrentStatus.get(target_characternode.StatusEffects.STUN) > 0:
		damage *= 1.5
		target_characternode.CurrentStatus.set(target_characternode.StatusEffects.STUN, 0.0)
		if attack_args.has(target_characternode.StatusEffects.STUN):
			attack_args.set(target_characternode.StatusEffects.STUN, 0.0)
	
	target_characternode.take_damage(damage, parent_player.global_position.direction_to(target.position)*knb_mult, attack_args)
	
