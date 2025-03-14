@tool
extends ActionLeaf

#fix demon spawn component issues
func tick(actor: Node, _blackboard: Blackboard) -> int:
	set_physics_process(true)
	actor.demon_check = false
	actor.demon.visible = true
	actor.random_spawn.random_spawn(actor.demon, actor.player, -15.0, 15.0)
	return SUCCESS
