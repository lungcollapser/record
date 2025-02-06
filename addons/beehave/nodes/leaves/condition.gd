@tool
@icon("../../icons/condition.svg")
class_name ConditionLeaf extends Leaf

	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemy_target = actor.enemy.target
	if enemy_target == Player:
		return FAILURE
		print("ayo")
	else:
		enemy_target = null
		return SUCCESS
		
