extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.eye_hitbox_one.get_collider() is Player and actor.eye_hitbox_two.get_collider() is Player:
		return FAILURE
	else:
		return SUCCESS
		
