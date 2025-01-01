extends RigidBody3D

@onready var pizza = $"."
@onready var item_spawn = preload("res://scenes/itemspawncomponent.tscn").instantiate()
var player_pick_up


func _ready() -> void:
	player_pick_up = get_tree().get_first_node_in_group("pickup")
	Events.connect("call_item_spawn", Callable(self, "item_spawn"))

func _physics_process(_delta: float):
		eat_pizza()
		item_spawn.item_spawn()
		
func eat_pizza():
	var pizza_collider = player_pick_up.get_collider()
	if Input.is_action_just_pressed("interact") and pizza_collider == pizza and HealthBar.value < 100:
		queue_free()
		HealthBar.value += 5
		SanityBar.value += 10
		

	
