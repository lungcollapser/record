extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.demon_crawl_speed = 0.005
		1: actor.demon.set_physics_process(false)
	print_debug(actor.movement_behavior)
	return SUCCESS
	
	
