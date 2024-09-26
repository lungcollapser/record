extends RigidBody3D


func _on_body_entered(body: Node):
	get_tree().call_group("Bussin", "grind_body")
