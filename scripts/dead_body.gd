extends RigidBody3D
class_name DeadBody

var player_hold
var player_attack
var dead_body_check = true
var dead_body_part_behavior = randi_range(0, 9)

@onready var dead_body = $"."
@onready var dead_body_shape = $deadbodyshape
@onready var left_leg = preload("res://scenes/left_leg_body.tscn").instantiate()
@onready var right_leg = preload("res://scenes/right_leg_body.tscn").instantiate()
@onready var left_arm = preload("res://scenes/left_arm_body.tscn").instantiate()
@onready var right_arm = preload("res://scenes/right_arm_body.tscn").instantiate()
@onready var head = preload("res://scenes/head_body.tscn").instantiate()





func _ready() -> void:
	player_hold = get_tree().get_first_node_in_group("hold")
	player_attack = get_tree().get_first_node_in_group("attack")
	Events.connect("call_dead_body_explosion", Callable(self, "dead_body_explosion"))

	


func dead_body_explosion():
	var dismember_collider = player_attack.get_collider()
	if dismember_collider == dead_body:
		queue_free()
		match dead_body_part_behavior:
			0: right_leg.queue_free()
			1: right_arm.queue_free()
			2: left_arm.queue_free()
			3: left_leg.queue_free()
			4: head.queue_free()
			5: null
			6: null
			7: null
			8: null
			9: null
		print(dead_body_part_behavior)
			
		get_parent().add_child(left_leg)
		get_parent().add_child(right_leg)
		get_parent().add_child(right_arm)
		get_parent().add_child(left_arm)
		get_parent().add_child(head)
		right_leg.global_position = player_hold.global_position
		left_leg.global_position = player_hold.global_position 
		left_arm.global_position = player_hold.global_position 
		right_arm.global_position = player_hold.global_position 
		head.global_position = player_hold.global_position 
		SanityBar.value -= 5
		
	
