extends CharacterBody3D

const ENEMY_SPEED = 0.08
var enemy_health = 100
var player
var player_area
@export var player_path : NodePath
@onready var nav_agent = $EnemyNavigation

func _ready():
	call_deferred("enemy_chase")
	player = get_tree().get_nodes_in_group("player")[0]
	player_area = get_tree().get_nodes_in_group("player_area")
	
func enemy_chase():
	await get_tree().physics_frame
	nav_agent.set_target_position(player.global_position)
	var velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
	move_and_collide(velocity)
	

func _on_area_3d_body_entered(body):
	if body == player:
		enemy_chase()
		print("poopy")
		
func _physics_process(delta: float) -> void:
	enemy_chase()
	
