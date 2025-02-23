extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.enemy_move_positions()
	if actor.aggro_check == true or actor.stun_check == false:
		return FAILURE
	else:
		return RUNNING
