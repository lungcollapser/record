@tool
extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.player.global_position.distance_to(actor.global_position) >= 4 and actor.aggro_check == false:
		return FAILURE
	else:
		return SUCCESS
