@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.demon_spawn()
	return SUCCESS
