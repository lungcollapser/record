@tool
@icon("../../icons/action.svg")
class_name FirstPosition extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	var enemy_roaming = actor.enemy.enemy_first_position()
	if enemy_roaming == false:
		return FAILURE
		
	else:
		print("gayo")
		enemy_roaming = true
		return SUCCESS
