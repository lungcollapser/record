@tool

extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.axis_lock_linear_x = false
	actor.axis_lock_linear_y = false
	actor.axis_lock_linear_z = false
	actor.enemy_roam_check = false
	actor.enemy_chase()
	return SUCCESS

	
