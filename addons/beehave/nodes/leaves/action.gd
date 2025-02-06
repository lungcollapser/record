@tool
@icon("../../icons/action.svg")
class_name StartRoaming extends Leaf


## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func get_class_name() -> Array[StringName]:
	var classes := super()
	classes.push_back(&"StartRoaming")
	return classes
	
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var enemy_roaming = actor.enemy.enemy_first_position()
	if enemy_roaming == false:
		return FAILURE
		
	else:
		print("gayo")
		enemy_roaming = true
		return SUCCESS
