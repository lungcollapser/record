@tool
extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.demon.global_position.distance_to(actor.player.global_position) <= 20 or SanityBar.value <= 75:
		return SUCCESS
	else:
		return FAILURE
