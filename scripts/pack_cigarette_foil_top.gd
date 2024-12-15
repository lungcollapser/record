extends RigidBody3D

@onready var cigarette = $"."

func _ready() -> void:
	Events.emit_signal("call_item_spawn", cigarette.global_position)
