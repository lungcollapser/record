@tool
extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.demon.visible = true
	actor.set_physics_process(true)
	return SUCCESS
