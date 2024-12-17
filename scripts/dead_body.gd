extends RigidBody3D
class_name DeadBody

var player_hold
var player_attack
var dead_body_check = true
@onready var dead_body = $"."
@onready var dead_body_shape = $deadbodyshape
@onready var dead_body_parts = preload("res://scenes/dead_body_parts.tscn")

func _ready() -> void:
	player_hold = get_tree().get_first_node_in_group("hold")
	player_attack = get_tree().get_first_node_in_group("attack")
	Events.connect("call_dead_body_explosion", Callable(self, "dead_body_explosion"))


func dead_body_explosion():
	var dismember_collider = player_attack.get_collider()
	var dead_body_parts_instance = dead_body_parts.instantiate()
	if dismember_collider == dead_body:
		queue_free()
		get_parent().add_child(dead_body_parts_instance)
		dead_body_parts_instance.global_position = player_hold.global_position 
		Events.emit_signal("call_item_spawn")
		SanityBar.value -= 5
		
	
