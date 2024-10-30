extends RigidBody3D
class_name DeadBody

var player_hold
var player_pick_up
@onready var dead_body = $"."
@onready var dead_body_shape = $deadbodyshape
@onready var dead_body_parts = preload("res://scenes/dead_body_parts.tscn")

func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]


func _physics_process(_delta: float) -> void:
	var dismember_collider = player_pick_up.get_collider()
	var dead_body_parts_instance = dead_body_parts.instantiate()
	if Input.is_action_just_pressed("attack") and dismember_collider == dead_body and dismember_collider.is_in_group("Dismember"):
		queue_free()

	
	if Input.is_action_just_pressed("attack") and dismember_collider == dead_body and dismember_collider.is_in_group("Dismember"):
		get_parent().add_child(dead_body_parts_instance)
		dead_body_parts_instance.global_position = player_hold.global_position 
	
