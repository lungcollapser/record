extends Node3D


func _on_head_body_body_entered(body):
	if body.is_in_group("stow"):
		print("hellow")
		queue_free()

func _on_right_leg_body_body_entered(body):
	if body.is_in_group("stow"):
		print("hellow")
		queue_free()

func _on_right_arm_body_body_entered(body):
	if body.is_in_group("stow"):
		print("hellow")
		queue_free()

func _on_left_leg_body_body_entered(body):
	if body.is_in_group("stow"):
		print("hellow")
		queue_free()


func _on_left_arm_body_body_entered(body):
	if body.is_in_group("stow"):
		print("hellow")
		queue_free()
		
