@tool
@icon("../../icons/action.svg")
class_name FirstPosition extends Leaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.enemy.enemy_move_positions()
	return RUNNING
	
	
