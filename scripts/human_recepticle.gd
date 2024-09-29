extends RigidBody3D

func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int):
	if body.is_in_group("Bussin"):
		body.queue_free()
		BloodBar.value += 10

func stow_receptacle():
	if Input.is_action_just_pressed("stow"):
		queue_free()
		
