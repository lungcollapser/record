extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.demon_nav.distance_to_target() <= 3:
		return SUCCESS
	else:
		return FAILURE
