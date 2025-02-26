extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if SanityBar.value <= 99:
		return SUCCESS
	else:
		return FAILURE
