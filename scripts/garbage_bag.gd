extends RigidBody3D
class_name GarbageBag

var player_hold
var player_pick_up
@onready var garbage = $"."
@onready var pizza = preload("res://scenes/pizza.tscn")
@onready var cigarette = preload("res://scenes/PackCigaretteFoilTop.tscn")

func _ready() -> void:
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pick_up = get_tree().get_nodes_in_group("pickup")[0]


func _physics_process(_delta: float) -> void:
	var garbage_collider = player_pick_up.get_collider()
	var pizza_instance = pizza.instantiate()
	var cigarrette_instance = cigarette.instantiate()
	if Input.is_action_just_pressed("leftattack") and garbage_collider == garbage and garbage_collider.is_in_group("garbage"):
		queue_free()
		get_parent().add_child(pizza_instance)
		get_parent().add_child(cigarrette_instance)
		pizza_instance.global_position = player_hold.global_position
		cigarrette_instance.global_position = player_hold.global_position
		
