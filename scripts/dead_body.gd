extends RigidBody3D


@onready var collision_shape = $CollisionShape3D

func grind_body(body):
	queue_free()
