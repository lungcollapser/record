@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.initial_behavior:
		0: actor.demon_chase()
		1: actor.demon_chase()
	return SUCCESS
