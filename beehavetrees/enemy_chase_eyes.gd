extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.enemy.enemy_chase() 
	return SUCCESS
