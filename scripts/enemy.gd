extends CharacterBody3D

const ENEMY_SPEED = 0.1
var enemy_health = 100
var player
@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready():
	call_deferred("enemy_setup")
	player = get_tree().get_nodes_in_group("player")[0]
	
	
	
func enemy_setup():
	await get_tree().physics_frame
	nav_agent.set_target_position(player.global_position)
	var velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
	move_and_collide(velocity)
	
	
func _physics_process(_delta: float):
	enemy_setup()
	
	
