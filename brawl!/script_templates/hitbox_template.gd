extends Hitbox

#Variables here

#Overwrite this with desired behavior. Template prebuilt with a basic attack without effects
func attack_effect(target: CharacterBody2D) -> void:
	if ControllerHandler.CONTROLLER_NODE_MAP.values().has(target):
		var target_characternode: CharacterBase = target.CharacterNode
		if target_characternode.block_duration > 0.0:
			target_characternode.counter_success()
			target_characternode.block_duration = 0.0
			parent_player.parent_movementnode.velocity = target.global_position.direction_to(global_position)*400
			parent_player.CurrentStatus.set(parent_player.StatusEffects.STUN, 0.2)
			return
		
		target_characternode.take_damage(parent_player.ATK, global_position.direction_to(target.position))
		
