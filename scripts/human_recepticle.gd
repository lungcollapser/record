extends RigidBody3D

@onready var collision = $HumanReceptacleShape
@onready var human_receptacle  = preload("res://scenes/human_receptacle.tscn").instantiate()
var player_hold
var player_pick_up
var receptacle_amount = 1


func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]

func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int):
	if body.is_in_group("Bussin"):
		body.queue_free()
		BloodBar.value += 10
		
func _physics_process(delta: float) -> void:
	var receptacle_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("dropreceptacle") and receptacle_amount == 1: 
		receptacle_amount -= 1
		get_parent().add_child(human_receptacle)
		human_receptacle.global_position = player_hold.global_position
		
		
	if Input.is_action_just_pressed("stow") and receptacle_collider != null and receptacle_collider.is_in_group("stow"):
		receptacle_amount += 1
		
		human_receptacle.visible = false
	if Input.is_action_just_pressed("dropreceptacle"):
		
		human_receptacle.visible = true
