extends CharacterBody3D

@onready var demon = $"."
@onready var demon_mesh = $demonmesh
@onready var demon_shape = $demonshape
@onready var demon_nav = $demonnav

var player
var player_spawn
var demon_spawn_check
var demon_target = null
var initial_behavior = randi_range(0, 1)
var action_behavior = randi_range(0, 1)
var movement_behavior = randi_range(0, 1)
var spawn_behavior = randi_range(0, 3)
var demon_movement_check = false
var demon_check = true

var spawn_point_one
var spawn_point_two
var spawn_point_three
var spawn_point_four


const DEMON_CRAWL_SPEED = 3
const DEMON_RUN_SPEED = 8

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player_spawn = get_tree().get_first_node_in_group("spawnsplayer")
	
		
func _physics_process(delta: float) -> void:
	var demon_run_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_RUN_SPEED * delta
	var demon_crawl_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_CRAWL_SPEED * delta
	
	
	if demon_movement_check == false:
		move_and_collide(demon_run_velocity)
	else: 
		move_and_collide(demon_crawl_velocity)
	

func demon_chase():
	var demon_look_position = player.global_position
	demon_look_position.y = player.global_position.y
	demon_nav.set_target_position(player.global_position)
	if demon_look_position != Vector3.ZERO:
			look_at(demon_look_position)
	
func demon_spawn():
	if demon_check == true:
		set_physics_process(true)
		demon_check = false
		demon.visible = true
		demon.set_global_position(Vector3(player.global_position.x + randf_range(-15.0, 15.0), 2, player.global_position.z + randf_range(-15.0, 15.0)))

func demon_idle():
	set_physics_process(true)
	print("ayoooo")
	demon_nav.set_target_position(demon.global_position.x + randf_range(-20.0, 20.0), 0, demon.global_position.z + randf_range(-20.0, 20.0))
	look_at(demon_nav.target_position)
			
			
