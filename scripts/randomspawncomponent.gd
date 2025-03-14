extends RigidBody3D

func random_spawn(target, second_target, randf_one, randf_two) -> float:
	target.set_global_position(Vector3(second_target.global_position.x + randf_range(randf_one, randf_two), 2, second_target.global_position.z + randf_range(randf_one, randf_two)))
	return randf_one and randf_two
