extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.demon_idle();
	print("ayo")
	return SUCCESS
