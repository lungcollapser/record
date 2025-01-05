extends RigidBody3D
#variables for importing nodes/scenes.
@onready var pizza = $"."
@onready var item_spawn = $itemspawncomponent
#boolean/state machine/group variables.
var player_pick_up

#ready function.
func _ready() -> void:
	player_pick_up = get_tree().get_first_node_in_group("pickup")
	Events.connect("call_item_spawn", Callable(self, "item_spawn"))
#"main"
func _physics_process(_delta: float):
		eat_pizza()
	
		#currently this item spawn component DOES NOT work.
#function for the player eating pizza. currently this raises health AND sanity (bound to change in the future).	
func eat_pizza():
	var pizza_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("interact") and pizza_collider == pizza and HealthBar.value < 100:
		queue_free()
		HealthBar.value += 5
		SanityBar.value += 10
		

	
