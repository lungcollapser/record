@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.movement_behavior:
		0: actor.demon_movement_check = true
		1: actor.player.player_health = 0
	return SUCCESS
	
	
