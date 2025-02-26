extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.enemy.global_position.distance_to(actor.player.global_position) >= 8 and actor.aggro_check == false:
		return FAILURE
	else:
		return SUCCESS
