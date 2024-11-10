extends RigidBody3D
class_name HumanReceptacle


@onready var collision = $HumanReceptacleShape
@onready var human_receptacle  = $"."
var player_hold
var player_pick_up
var receptacle_amount = true
var dead_body_parts

func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]
	
	

func _physics_process(_delta: float):
	
	drop_receptacle()
	
	if receptacle_amount == true:
		Events.emit_signal("call_receptacle_speed")
	else:
		Events.emit_signal("call_normal_speed")
	
	if Input.is_action_just_pressed("dropreceptacle"):
		collision.disabled = false
		visible = true
	
func drop_receptacle():
	var receptacle_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("dropreceptacle") and receptacle_amount == true: 
		human_receptacle.global_position = player_hold.global_position
		receptacle_amount = false
		
	if Input.is_action_just_pressed("stow") and receptacle_collider != null and receptacle_collider.is_in_group("stow"):
		receptacle_amount = true
		visible = false
		collision.disabled = true



func _on_body_entered(body: Node):
	if body.is_in_group("Bussin"):
		body.queue_free()
		BloodBar.value += 1
