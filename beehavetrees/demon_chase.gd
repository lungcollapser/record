extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.demon_chase()
	return SUCCESS
