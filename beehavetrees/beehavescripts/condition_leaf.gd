extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.eye_hitbox_one.get_collider() is Player or actor.eye_hitbox_two.get_collider() is Player or actor.aggro_check == true:
		return FAILURE
	else:
		return SUCCESS
		
