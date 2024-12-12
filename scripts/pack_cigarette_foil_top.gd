extends RigidBody3D

@onready var cigarette = $"."

func _physics_process(delta: float) -> void:
	Events.emit_signal("call_item_spawn", cigarette)
