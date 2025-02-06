@tool
@icon("../../icons/condition.svg")
class_name ConditionLeaf extends Leaf

## Conditions are leaf nodes that either return SUCCESS or FAILURE depending on
## a single simple condition. They should never return `RUNNING`.

func get_class_name() -> Array[StringName]:
	var classes := super()
	classes.push_back(&"ConditionLeaf")
	return classes
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemy_target = actor.enemy.target
	if enemy_target == Player:
		return FAILURE
		print("ayo")
	else:
		enemy_target = null
		return SUCCESS
		
