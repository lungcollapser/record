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

var demon_crawl_speed = 0.04
const DEMON_RUN_SPEED = 6

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(_delta: float) -> void:
	demon_chase()
	
	if SanityBar.value >= 100:
		set_physics_process(false)
	else:
		set_physics_process(true)
	
	
func demon_chase():
	var demon_crawl_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * demon_crawl_speed
	var _demon_run_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_RUN_SPEED
	var demon_look_position = player.global_position
	demon_look_position.y = player.global_position.y
	demon_nav.set_target_position(player.global_position)
	move_and_collide(demon_crawl_velocity)
	if demon_look_position != Vector3.ZERO:
			look_at(demon_look_position)
	
