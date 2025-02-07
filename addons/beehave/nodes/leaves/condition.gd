@tool
@icon("../../icons/condition.svg")
class_name RoamingCheck extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	var enemy_target = actor.enemy.target
	if enemy_target == Player and actor.enemy.global_position :
		return FAILURE
	else:
		enemy_target = null
		return SUCCESS
