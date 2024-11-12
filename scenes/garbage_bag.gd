extends RigidBody3D

func _on_body_entered(body: Node):
	if body.is_in_group("psxarms") and Input.is_action_just_pressed("attack"):
		queue_free()
