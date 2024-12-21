extends RigidBody3D
class_name ItemSpawn

#works if individually applied to each object, but want to use it in this component system
#still doesn't work even while using arguments
#maybe try characterbody2d
func item_spawn():
	var MIN_LAUNCH_HEIGHT = 0.5
	var MAX_LAUNCH_HEIGHT = 1.5
	var MAX_LAUNCH_RANGE = 1.5
	var MIN_LAUNCH_RANGE = 0.5
	var rand_height = MIN_LAUNCH_HEIGHT + (randf() * MAX_LAUNCH_HEIGHT)
	var rand_dir = Vector3.FORWARD.rotated(Vector3.UP, randf() * 2 * PI)
	var rand_pos = rand_dir * (MIN_LAUNCH_RANGE + (randf() * MAX_LAUNCH_RANGE))
	rand_pos.y = rand_height
	apply_central_impulse(rand_pos)
	
