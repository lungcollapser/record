@tool
@icon("../../icons/condition.svg")
class_name RoamingCheck extends Leaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.eye_hitbox_one.get_collider() is Player or actor.eye_hitbox_two.get_collider() is Player:
		return SUCCESS
	else: 
		return FAILURE
