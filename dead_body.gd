extends RigidBody3D

@onready var dead_body = $deadbody
@onready var collision_shape = $CollisionShape3D
@onready var ray = $Node3D/RayCast3D

func grind_body():
	queue_free()
