@tool
extends ConditionLeaf


func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if SanityBar.value <= 99:
		return SUCCESS
	else:
		return FAILURE
