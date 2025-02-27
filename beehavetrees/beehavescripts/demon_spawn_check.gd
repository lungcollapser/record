extends ConditionLeaf


func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if SanityBar.value == 100:
		return SUCCESS
	else:
		return FAILURE
