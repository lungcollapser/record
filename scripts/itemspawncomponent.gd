extends RigidBody3D
class_name ItemSpawnComponent

@onready var item = get_parent()
var timeout_check : bool = true
var x_force_multiply : float = 17.5
var y_force_multiply : float = 25.5
var z_force_multiply : float = 15.5


func _physics_process(delta: float):
	if timeout_check == true:
		item.apply_central_impulse(Vector3(randf_range(100.0, -100.0) * x_force_multiply, randf_range(100.0, -100.0) * y_force_multiply, randf_range(100.0, -100.0) * z_force_multiply) * delta)
		item.apply_torque_impulse(Vector3(randf_range(100.0, -100.0),randf_range(100.0, -100.0), randf_range(100.0, -100.0)) * delta)
	else:
		pass
	

func _on_timer_timeout() -> void:
	timeout_check = false
