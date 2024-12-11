extends RigidBody3D

@onready var pizza = $"."
var player_pick_up

func _ready() -> void:
	player_pick_up = get_tree().get_first_node_in_group("pickup")
	Events.connect("call_item_spawn", Callable(self, "item_spawn"))

func _physics_process(_delta: float):
		eat_pizza()
		
func eat_pizza():
	var pizza_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("interact") and pizza_collider == pizza and HealthBar.value < 100:
		queue_free()
		HealthBar.value += 5
		
	
func item_spawn():
	var MIN_LAUNCH_HEIGHT = 0.5
	var MAX_LAUNCH_HEIGHT = 1.5
	var MAX_LAUNCH_RANGE = 1.5
	var MIN_LAUNCH_RANGE = 0.5
	var rand_height = MIN_LAUNCH_HEIGHT + (randf() * MAX_LAUNCH_HEIGHT)
	var rand_dir = Vector3.FORWARD.rotated(Vector3.UP, randf() * 2 * PI)
	var rand_pos = rand_dir * (MIN_LAUNCH_RANGE + (randf() * MAX_LAUNCH_RANGE))
	rand_pos.y = rand_height
	apply_central_impulse(rand_pos)
