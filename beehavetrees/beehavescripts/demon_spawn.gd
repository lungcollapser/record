extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.demon.visible = true
	return SUCCESS
