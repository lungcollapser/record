extends Player


func _process(delta: float) -> void:
	if dead_body_check != null:
		visible = false
		collision_mask = 3
