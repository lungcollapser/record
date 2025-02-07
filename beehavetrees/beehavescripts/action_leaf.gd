@tool
@icon("../../icons/action.svg")
class_name SecondPosition extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	var enemy_roaming = actor.enemy.enemy_second_position()
	if enemy_roaming == false:
		return FAILURE
		
	else:
		print("bayo")
		
		enemy_roaming = true
		return SUCCESS
		
