extends RigidBody3D
class_name ItemSpawnComponent

@onready var item = get_parent()
var MIN_LAUNCH_HEIGHT = 0.5
var MAX_LAUNCH_HEIGHT = 1.5
var MAX_LAUNCH_RANGE = 1.5
var MIN_LAUNCH_RANGE = 0.5
var rand_height = MIN_LAUNCH_HEIGHT + (randf() * MAX_LAUNCH_HEIGHT)
var rand_dir = Vector3.FORWARD.rotated(Vector3.UP, randf() * 2 * PI)
var rand_pos = rand_dir * (MIN_LAUNCH_RANGE + (randf() * MAX_LAUNCH_RANGE))
var timeout_check : bool = true



func _physics_process(delta: float):
	if timeout_check == true:
		item.apply_central_impulse(Vector3(0, 10, 0) * delta)
		print("ayo")
	else:
		pass
	

func _on_timer_timeout() -> void:
	timeout_check = false
