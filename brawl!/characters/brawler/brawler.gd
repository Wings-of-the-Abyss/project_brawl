extends CharacterBase

@onready var a: Area2D = $hitboxes/A
@onready var b: Area2D = $hitboxes/B
@onready var rt_a: Area2D = $hitboxes/RT_A
@onready var rt_b: Area2D = $hitboxes/RT_B
@onready var lt_a: Area2D = $hitboxes/LT_A
@onready var lt_b: Area2D = $hitboxes/LT_B

@onready var hitboxes: Node2D = $hitboxes

#Variables here
var hitcheck: float = -1.0
var hit_success: bool = false

var rush_duration: float = 0.3

#DO NOT USE PHYSICS PROCESS! it is used to handle input and overriding will be inconvenient.
func _process(delta: float) -> void:
	for i: Hitbox in hitboxes.get_children():
		if i.has_overlapping_bodies():
			hit_success = true
	if hitcheck > 0:
		hitcheck -= delta
		if hitcheck <= 0:
			parent_movementnode.velocity = parent_movementnode.velocity.lerp(Vector2.ZERO, 0.9)
			if hit_success:
				hitcheck = -1.0
				hit_success = false
			else:
				parent_movementnode.lock = 0.5
				

func atk_A() -> void:
	attack_cooldown = 0.3
	a.active = true
	await get_tree().create_timer(0.2).timeout
	a.active = false
func atk_B() -> void:
	attack_cooldown = 0.3
	b.active = true
	await get_tree().create_timer(0.2).timeout
	b.active = false
func atk_RT_A() -> void:
	attack_cooldown = 0.2
	parent_movementnode.velocity =Vector2.from_angle(rotation)*parent_movementnode.SPEED*4
	parent_movementnode.lock = 0.1
	hitcheck = 0.1
	rt_a.active = true
	await  get_tree().create_timer(0.075).timeout
	rt_a.active = false
func atk_RT_B() -> void:
	attack_cooldown = 0.3
	rt_b.active = true
	await  get_tree().create_timer(0.1).timeout
	rt_b.active = false
func atk_LT_A() -> void:
	print("LT A attack")
func atk_LT_B() -> void:
	print("LT B attack")
func counter_success() -> void:
	print("counter")

#Take Damage Override if needed
#func take_damage(dmg: float, kb: Vector2, additional_args: Dictionary = {}):
	#pass
