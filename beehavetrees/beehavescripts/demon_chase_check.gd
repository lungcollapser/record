extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.demon.global_position.distance_to(actor.player.global_position) <= 50:
		return SUCCESS
	else:
		return FAILURE
