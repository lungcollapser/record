@tool

extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.axis_lock_linear_x = true
	actor.axis_lock_linear_y = true
	actor.axis_lock_linear_z = true
	
	actor.enemy.look_at(actor.player.global_position)
	return SUCCESS

	
