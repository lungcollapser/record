extends Node3D

func _on_head_body_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body is HumanReceptacle:
		print("hellow")
		queue_free()



func _on_right_leg_body_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body is HumanReceptacle:
		print("hellow")
		queue_free()



func _on_right_arm_body_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body is HumanReceptacle:
		print("hellow")
		queue_free()


func _on_left_leg_body_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body is HumanReceptacle:
		print("hellow")
		queue_free()



func _on_left_arm_body_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	if body is HumanReceptacle:
		print("hellow")
		queue_free()
