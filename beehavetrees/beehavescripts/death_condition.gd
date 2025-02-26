extends "res://beehavetrees/beehavescripts/condition_leaf.gd"


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.enemy_health <= 0 and actor.enemy_dead_body_check == true:
		return SUCCESS
	else:
		return FAILURE
