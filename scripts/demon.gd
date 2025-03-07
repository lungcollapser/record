extends CharacterBody3D

@onready var demon = $"."
@onready var demon_mesh = $demonmesh
@onready var demon_shape = $demonshape
@onready var demon_nav = $demonnav


var player
var demon_spawn_check
var demon_target = null
var initial_behavior = randi_range(0, 1)
var action_behavior = randi_range(0, 1)
var movement_behavior = randi_range(0, 1)

const DEMON_CRAWL_SPEED = 3
const DEMON_RUN_SPEED = 8

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)
	
func _physics_process(delta: float) -> void:
	var demon_run_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_RUN_SPEED * delta
	move_and_collide(demon_run_velocity)
	

	
	
	
func demon_chase():
	var demon_look_position = player.global_position
	demon_look_position.y = player.global_position.y
	demon_nav.set_target_position(player.global_position)
	if demon_look_position != Vector3.ZERO:
			look_at(demon_look_position)
	
