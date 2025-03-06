@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.demon_crawl_speed = 0.008
		1: actor.global_position = actor.player.global_position
	
	print(actor.movement_behavior)
	return SUCCESS
	
	
