extends RigidBody3D
class_name GarbageBag

var player_hold
var player_pick_up
var garbage_bag_check = true
@onready var garbage = $"."
@onready var pizza = preload("res://scenes/pizza.tscn")
@onready var cigarette = preload("res://scenes/PackCigaretteFoilTop.tscn")

func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]
	
	Events.connect("call_garbage_bag_explosion", Callable(self, "garbage_bag_explosion"))

func garbage_bag_explosion():
	var pizza_instance = pizza.instantiate()
	var cigarrette_instance = cigarette.instantiate()
	if garbage_bag_check == true:
		garbage_bag_check = false
		queue_free()
		get_parent().add_child(pizza_instance)
		get_parent().add_child(cigarrette_instance)
		pizza_instance.global_position = player_hold.global_position
		cigarrette_instance.global_position = player_hold.global_position
		
