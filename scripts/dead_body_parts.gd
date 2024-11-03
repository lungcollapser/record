extends Node3D


var dead_body_parts

func dead_body_destroy():
	await get_tree().create_timer(3).timeout
	self.queue_free()
	
	
	
