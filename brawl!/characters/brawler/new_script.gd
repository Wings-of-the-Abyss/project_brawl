extends CharacterBase


#Variables here

#DO NOT USE PHYSICS PROCESS! it is used to handle input and overriding will be inconvenient.
func _process(delta: float) -> void:
	pass

func atk_A() -> void:
	print("A attack")
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

