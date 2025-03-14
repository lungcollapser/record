@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.action_behavior:
		0: print("1")
		1: print("1")
	return SUCCESS
