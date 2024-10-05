extends CharacterBody3D

const ENEMY_SPEED = 0.08
var enemy_health = 100
var player
var player_area
var target = null
@export var player_path : NodePath
@onready var nav_agent = $EnemyNavigation
@onready var enemy_area = $EnemyArea

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_area = get_tree().get_nodes_in_group("player_area")
	
func _physics_process(delta: float) -> void:
	if target != null:
		await get_tree().physics_frame
		nav_agent.set_target_position(player.global_transform.origin)
		var velocity = (nav_agent.get_next_path_position() - transform.origin).normalized() * ENEMY_SPEED
		move_and_collide(velocity)
		

func _on_enemy_area_body_entered(body: Node3D):
	if body is Player:
		target != null
		print("aodkjaopiwd")
