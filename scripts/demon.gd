extends CharacterBody3D

@onready var demon = $"."
@onready var demon_mesh = $demonmesh
@onready var demon_shape = $demonshape
@onready var demon_nav = $demonnav


var player
var demon_spawn_check


var demon_target = null

const DEMON_CRAWL_SPEED = 0.02
const DEMON_RUN_SPEED = 4

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(_delta: float) -> void:
	demon_spawn()
	demon_chase()

func demon_spawn():
	if SanityBar.value <= 99:
		demon_mesh.visible = true
		demon_shape.visible = true
		
#crawl doesnt work on this fix later
func demon_chase():
	var demon_crawl_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_CRAWL_SPEED
	var demon_run_velocity = (demon_nav.get_next_path_position() - global_position).normalized() * DEMON_RUN_SPEED
	var demon_look_position = player.global_position
	demon_look_position.y = player.global_position.y
	await get_tree().physics_frame
	if demon_target == Player:
		demon_nav.set_target_position(player.global_position)
		if demon_look_position != Vector3.ZERO:
				look_at(demon_look_position)
		if demon.global_position <= player.global_position:
			move_and_collide(demon_run_velocity)
			print("hello")
		else: 
			move_and_collide(demon_crawl_velocity)
			print("herro")
		
	

func _on_demonarea_body_entered(body) -> void:
	if body is Player:
		demon_target = Player

func _on_demonarea_body_exited(body) -> void:
	if body is Player:
		demon_target = null
		
