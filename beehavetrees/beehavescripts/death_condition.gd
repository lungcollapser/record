@tool
extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.enemy_health <= 9 and actor.enemy_dead_body_check == true:
		return SUCCESS
	else:
		return FAILURE
