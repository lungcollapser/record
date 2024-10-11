extends CharacterBody3D



const ENEMY_SPEED = 0.06
var enemy_health = clamp(10, 0, 10)
var player
var player_area
var target
var enemy_navigation_link
var player_hold
@export var player_path : NodePath
@onready var nav_agent = $EnemyNavigation
@onready var enemy_area = $EnemyArea
@onready var enemy_shape = $EnemyShape
@onready var dead_body_parts = preload("res://scenes/dead_body_parts.tscn").instantiate()


func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	
	
func _physics_process(_delta: float) -> void:
	enemy_chase()
	
func enemy_chase():
	if target == Player:
		await get_tree().physics_frame
		nav_agent.set_target_position(player.global_position)
		var velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
		move_and_collide(velocity)
		

func _on_enemy_area_body_entered(body: Node3D):
	if body is Player:
		target = Player
		

func _on_enemy_area_body_exited(body: Node3D):
	if body is Player:
		target = null
# FIX THIS TOMORROW. U
func enemy_lose_health():
	enemy_health -= 1
	if enemy_health <= 0:
		visible = false
		
		
