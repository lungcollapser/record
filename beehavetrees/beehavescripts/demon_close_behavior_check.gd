extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.demon_nav.distance_to_target() <= 5:
		return SUCCESS
	else:
		return FAILURE
