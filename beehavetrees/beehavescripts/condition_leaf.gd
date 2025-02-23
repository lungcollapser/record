extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.aggro_check == false or actor.stun_check == false:
		return SUCCESS
	else:
		return FAILURE
		
