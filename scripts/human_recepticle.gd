extends RigidBody3D

func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int):
	if body.is_in_group("Bussin"):
		body.queue_free()
	if body.is_in_group("Bussin"):
		BloodBar.value += 10
