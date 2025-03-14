@tool
extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.demon.global_position.distance_to(actor.player.global_position) <= 15 or SanityBar.value <= 75:
		return SUCCESS
	else:
		return FAILURE
