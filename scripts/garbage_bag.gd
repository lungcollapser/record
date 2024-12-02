extends RigidBody3D
class_name GarbageBag

var player_hold
var player_attack
@onready var garbage = $"."
@onready var pizza = preload("res://scenes/pizza.tscn")
@onready var cigarette = preload("res://scenes/PackCigaretteFoilTop.tscn")

func _ready() -> void:
	player_hold = get_tree().get_first_node_in_group("hold")
	player_attack = get_tree().get_first_node_in_group("attack")
	Events.connect("call_garbage_bag_explosion", Callable(self, "garbage_bag_explosion"))

func garbage_bag_explosion():
	var garbage_collider = player_attack.get_collider()
	var pizza_instance = pizza.instantiate()
	var cigarrette_instance = cigarette.instantiate()
	if garbage_collider == garbage:
		queue_free()
		get_parent().add_child(pizza_instance)
		get_parent().add_child(cigarrette_instance)
		pizza_instance.global_position = player_hold.global_position
		cigarrette_instance.global_position = player_hold.global_position
		
