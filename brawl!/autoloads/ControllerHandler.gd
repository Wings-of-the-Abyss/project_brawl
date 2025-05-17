extends Node

var CONTROLLER_NODE_MAP: Dictionary[int, Variant] = {}

func _ready() -> void:
	Input.joy_connection_changed.connect(controller_update)

func controller_update(device: int, connected: bool) -> void:
	if connected:
		if CONTROLLER_NODE_MAP.keys().has(device):
			print("do the reassignment here")
		else:
			CONTROLLER_NODE_MAP[device] = null
	else:
		CONTROLLER_NODE_MAP[device] = null
	print(CONTROLLER_NODE_MAP)
