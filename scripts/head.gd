extends Node3D
class_name HeadActions

var endurance_check 
var picked_up_object 
var pick_up
var hold 
var pull_power = 6
const WALK_SPEED = 2.0
var speed = 0

func _ready():
	pick_up = get_tree().get_nodes_in_group("pickup")[0]
	hold = get_tree().get_nodes_in_group("hold")[0]

func pick_up_object():
	var collider = pick_up.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_up_object = collider
		
func drop_object():
	if picked_up_object != null:
		picked_up_object = null
		
func _physics_process(delta: float):
	if picked_up_object != null:
		var a = picked_up_object.global_position
		var b = hold.global_position
		picked_up_object.set_linear_velocity((b-a) * pull_power)
		
	if Input.is_action_just_pressed("interact"):
		if picked_up_object == null:
			pick_up_object()
		elif picked_up_object != null:
			drop_object()
			
	if picked_up_object is HumanReceptacle:
		speed = WALK_SPEED
		endurance_check = false
		
