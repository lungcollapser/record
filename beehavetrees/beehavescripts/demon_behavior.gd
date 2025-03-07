@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.move_and_collide(actor.demon_crawl_velocity)
		1: actor.player.player_health = 0
	return SUCCESS
	
	
