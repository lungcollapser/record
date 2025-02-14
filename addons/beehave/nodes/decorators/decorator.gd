@tool
@icon("../../icons/category_decorator.svg")
class_name Decorator extends BeehaveNode

## Decorator nodes are used to transform the result received by its child.
## Must only have one child.

var running_child: BeehaveNode = null


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = super._get_configuration_warnings()

	if get_child_count() != 1:
		warnings.append("Decorator should have exactly one child node.")

	return warnings


func after_run(actor: Node, blackboard: Blackboard) -> void:
	actor.enemy.enemy_random_move()
	


func get_class_name() -> Array[StringName]:
	var classes := super()
	classes.push_back(&"Decorator")
	return classes
