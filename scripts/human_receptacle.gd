extends RigidBody3D
class_name HumanReceptacle


@onready var collision = $HumanReceptacleShape
@onready var human_receptacle  = $"."
@onready var grinder_collision = $"HumanReceptacleGrinder"
var player_hold
var player_pick_up
var receptacle_amount = true
var dead_body_parts

func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]
	
	Events.connect("call_kill_floor_receptacle", Callable(self, "kill_floor_receptacle"))

func _physics_process(_delta: float):
#	wall_kill_floor()

	if BloodBar.value == 100:
		grinder_collision.monitoring = false
		
	
	if receptacle_amount == true:
		Events.emit_signal("call_receptacle_speed")
	else:
		Events.emit_signal("call_normal_speed")
		
	var receptacle_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("dropreceptacle") and receptacle_amount == true:
		human_receptacle.global_position = player_hold.global_position
		receptacle_amount = false
		collision.disabled = false
		visible = true
		
	if Input.is_action_just_pressed("stow") and receptacle_collider != null:
		receptacle_amount = true
		visible = false
		collision.disabled = true



func _on_human_receptacle_grinder_body_entered(body):
	if body.is_in_group("bodyparts"):
		body.queue_free()
		BloodBar.value += 10
		
func kill_floor_receptacle():
	if receptacle_amount == false:
		human_receptacle.global_position = player_hold.global_position
		linear_velocity = Vector3.ZERO
	
#func wall_kill_floor():
#	if human_receptacle.get_colliding_bodies() and receptacle_amount == true:
#		print(human_receptacle.get_contact_count())
#		print("herro")
#		kill_floor_receptacle()
		
