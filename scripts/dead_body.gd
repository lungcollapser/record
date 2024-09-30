extends RigidBody3D

func _process(_delta: float) -> void:
	replace_body()

func replace_body():
	if Input.is_action_pressed("dismember"):
		visible = false
