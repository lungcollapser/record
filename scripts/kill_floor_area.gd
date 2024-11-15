extends Area3D

func _on_body_entered(body):
	if body is HumanReceptacle:
		Events.emit_signal("call_kill_floor_receptacle")
