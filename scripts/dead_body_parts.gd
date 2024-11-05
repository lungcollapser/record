extends HumanReceptacle

func _physics_process(delta: float) -> void:
	human_receptacle = get_tree().get_nodes_in_group("stow")[0]


func _on_head_body_body_entered(body):
	if body.is_in_group("stow") or body is HumanReceptacle:
		print("hellow")
		queue_free()

func _on_right_leg_body_body_entered(body):
	if body.is_in_group("stow") or body is HumanReceptacle:
		print("hellow")
		queue_free()

func _on_right_arm_body_body_entered(body):
	if body.is_in_group("stow") or body is HumanReceptacle:
		print("hellow")
		queue_free()

func _on_left_leg_body_body_entered(body):
	if body.is_in_group("stow") or body is HumanReceptacle:
		print("hellow")
		queue_free()


func _on_left_arm_body_body_entered(body):
	if body.is_in_group("stow") or body is HumanReceptacle:
		print("hellow")
		queue_free()
