extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.enemy_dead_body_spawn()
	return SUCCESS
