@tool
@icon("../../icons/condition.svg")
class_name ConditionLeaf extends Leaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.eye_hitbox_one.get_collider() is Player or actor.eye_hitbox_two.get_collider() is Player:
		actor.aggro_check = false
		return SUCCESS
	else: 
		return FAILURE
