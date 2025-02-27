extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.demon_nav.distance_to_target() <= 15:
		return SUCCESS
	else:
		return FAILURE
