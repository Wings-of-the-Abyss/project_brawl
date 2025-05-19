extends Area2D
class_name Hitbox

var parent_player: CharacterBase

func _ready() -> void:
	parent_player = get_parent()
	set_collision_mask_value(parent_player.paired_controller+1, false)

func _on_body_entered(body: Node2D) -> void:
	attack_effect(body)

#Overwrite this to add hitbox functionality
func attack_effect(target: CharacterBody2D) -> void:
	pass
