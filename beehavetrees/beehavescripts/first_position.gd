@tool
@icon("../../icons/action.svg")
class_name FirstPosition extends Leaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.enemy._on_timer_timeout()
	return RUNNING
	
	
