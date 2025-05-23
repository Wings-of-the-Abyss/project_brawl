extends CharacterBase

@onready var a: Area2D = $hitboxes/A
@onready var b: Area2D = $hitboxes/B
@onready var rt_a: Area2D = $hitboxes/RT_A
@onready var rt_b: Area2D = $hitboxes/RT_B
@onready var lt_a: Area2D = $hitboxes/LT_A
@onready var lt_b: Area2D = $hitboxes/LT_B

@onready var hitboxes: Node2D = $hitboxes

#Variables here

#DO NOT USE PHYSICS PROCESS! it is used to handle input and overriding will be inconvenient.
func _process(delta: float) -> void:
	hitboxes.rotation = parent_movementnode.direction.angle()

func atk_A() -> void:
	attack_cooldown = 0.5
	a.active = true
	await get_tree().create_timer(0.4).timeout
	a.active = false
func atk_B() -> void:
	print("B attack")
func atk_RT_A() -> void:
	print("RT A attack")
func atk_RT_B() -> void:
	print("RT B attack")
func atk_LT_A() -> void:
	print("LT A attack")
func atk_LT_B() -> void:
	print("LT B attack")
func counter_success() -> void:
	print("counter")

#Take Damage Override if needed
#func take_damage(dmg: float, kb: Vector2, additional_args: Dictionary = {}):
	#pass
