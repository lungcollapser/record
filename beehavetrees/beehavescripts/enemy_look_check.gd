@tool
extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.player.global_position.distance_to(actor.global_position) >= 7 and actor.aggro_check == false:
		actor.axis_lock_linear_x = false
		actor.axis_lock_linear_y = false
		actor.axis_lock_linear_z = false
		return FAILURE
	else:
		return SUCCESS
