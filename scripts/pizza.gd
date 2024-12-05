extends RigidBody3D

@onready var pizza = $"."
var player_pick_up


func _ready() -> void:
	player_pick_up = get_tree().get_first_node_in_group("pickup")

func _physics_process(_delta: float):
		eat_pizza()
		
func eat_pizza():
	var pizza_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("interact") and pizza_collider == pizza and HealthBar.value < 100:
		queue_free()
		HealthBar.value += 5
		
	
