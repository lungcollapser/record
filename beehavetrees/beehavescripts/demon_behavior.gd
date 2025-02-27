extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.demon_crawl_speed = 0.008
		1: actor.global_position.y += actor.demon_crawl_speed 
	return SUCCESS
	
	
