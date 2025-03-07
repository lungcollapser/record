@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.enemy_roam_check = true
	actor.enemy_move_positions()
	return SUCCESS
	
