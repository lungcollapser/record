@tool
extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if SanityBar.value <= 99 and actor.demon_check == true:
		return SUCCESS
	else:
		return FAILURE
