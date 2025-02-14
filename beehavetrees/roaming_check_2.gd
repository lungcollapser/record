extends RoamingCheck

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var enemy_target = actor.enemy.target
	if enemy_target == Player or enemy_target != enemy.global_position:
		return FAILURE
	else:
		return SUCCESS
