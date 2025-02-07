@tool
@icon("../../icons/action.svg")
class_name FirstPosition extends Leaf

	
func tick(actor: Node, _blackboard: Blackboard) -> int:
	match actor.enemy.roaming_behavior:
		0: actor.enemy.enemy_first_position()
		1: actor.enemy.enemy_second_position()
		2: actor.enemy.enemy_third_position()
	print(actor.enemy.roaming_behavior)
	return SUCCESS
	
	


func _on_timer_timeout():
	return SUCCESS
