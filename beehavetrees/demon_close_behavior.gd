extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	match actor.action_behavior:
		0: actor.queue_free()
		1: actor.queue_free()
	return SUCCESS
