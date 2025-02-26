@tool
@icon("../../icons/action.svg")
class_name ActionLeaf extends Leaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.enemy.enemy_chase() 
	return SUCCESS
