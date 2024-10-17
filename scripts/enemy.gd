extends CharacterBody3D



const ENEMY_SPEED = 0.06
var enemy_health = clamp(10, 0, 10)
var player
var player_area
var target
var enemy_navigation_link
var player_hold
var player_arms 
@export var player_path : NodePath
@onready var nav_agent = $EnemyNavigation
@onready var enemy_area = $EnemyArea
@onready var enemy_shape = $EnemyShape
@onready var dead_body_parts = preload("res://scenes/dead_body_parts.tscn")




func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_arms = get_tree().get_nodes_in_group("fpsarmarea")[0]
	
	
func _physics_process(_delta: float) -> void:
	enemy_chase()
	
	var dead_body_parts_instance = dead_body_parts.instantiate()
	if enemy_health <= 0:
		get_parent().add_child(dead_body_parts_instance)
		dead_body_parts_instance.global_position = player_hold.global_position
		
	
func enemy_chase():
	if target == Player:
		await get_tree().physics_frame
		nav_agent.set_target_position(player.global_position)
		var velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
		move_and_collide(velocity)
		
		
func enemy_roaming():
	if target != Player:
		await get_tree().physics_frame
		nav_agent.set_target_position()

func _on_enemy_area_body_entered(body: Node3D):
	if body is Player:
		target = Player
		
	

func _on_enemy_area_body_exited(body: Node3D):
	if body is Player:
		target = null




func _on_enemy_hitbox_body_entered(body) -> void:
	if body is FpsCharacter:
		print("poopy")
		enemy_health -= 1
		if enemy_health == 0:
			visible = false
		
