extends CharacterBody3D

@onready var demon = $"."
@onready var demon_mesh = $demonmesh
@onready var demon_shape = $demonshape
@onready var demon_nav = $demonnav


var player
var demon_spawn_check
var demon_target = null
var action_behavior = randi_range(0, 1)
var movement_behavior = randi_range(0, 1)

var demon_crawl_speed = 0.04
const DEMON_RUN_SPEED = 6

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(_delta: float) -> void:
	demon_chase()
	
	
func demon_chase():
	var demon_crawl_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * demon_crawl_speed
	var demon_run_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_RUN_SPEED
	var demon_look_position = player.global_position
	demon_look_position.y = player.global_position.y
	await get_tree().physics_frame
	demon_nav.set_target_position(player.global_position)
	if demon_look_position != Vector3.ZERO:
			look_at(demon_look_position)
	if demon_nav.distance_to_target() <= 3:
		match action_behavior:
			0: move_and_collide(demon_run_velocity)
			1: queue_free()
	else:
		move_and_collide(demon_crawl_velocity)
