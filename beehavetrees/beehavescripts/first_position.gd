@tool
@icon("../../icons/action.svg")
class_name FirstPosition extends Leaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.enemy_roaming_timer.wait_time <= 0:
		actor.enemy.enemy_random_move()
	print(actor.enemy_roaming_timer.wait_time)
	return SUCCESS
	
	
