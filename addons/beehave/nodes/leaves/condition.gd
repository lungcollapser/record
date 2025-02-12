@tool
@icon("../../icons/condition.svg")
class_name RoamingCheck extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	var enemy_target = actor.enemy.target
	if enemy_target == Player:
		return FAILURE
	else:
		enemy_target = null
		return SUCCESS
