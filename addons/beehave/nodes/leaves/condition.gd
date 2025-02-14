@tool
@icon("../../icons/condition.svg")
class_name RoamingCheck extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.enemy.target != Player:
		return SUCCESS
	else:
		return FAILURE
