@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.demon_crawl_speed = 0.008
		1: actor.player.player_health = 0
	
	return SUCCESS
	
	
