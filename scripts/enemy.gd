extends CharacterBody3D



const ENEMY_SPEED = 0.06
var enemy_health = clamp(10, 0, 10)
var player
var player_area
var target
var enemy_navigation_link
var player_hold
var player_arms 
@onready var enemy = $"."
@export var player_path : NodePath
@onready var nav_agent = $EnemyNavigation
@onready var dead_body = preload("res://scenes/dead_body.tscn")




func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_arms = get_tree().get_nodes_in_group("fpsarmarea")[0]
	
	
	
func _physics_process(_delta: float) -> void:
	enemy_chase()
	
	var dead_body_instance = dead_body.instantiate()
	if enemy_health == 0:
		visible = false
		enemy.disabled = true
		get_parent().add_child(dead_body_instance)
		dead_body_instance.global_position = enemy.global_position
		
		
		
func enemy_chase():
	var enemy_look_position = player.global_position
	enemy_look_position.y = global_position.y
	if target == Player:
		await get_tree().physics_frame
		nav_agent.set_target_position(player.global_position)
		var velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
		if enemy_look_position != Vector3.ZERO:
			look_at(enemy_look_position)
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




func _on_enemy_hitbox_body_entered(body):
	if body is FpsCharacter:
		print(enemy_health)
		enemy_health -= 1
		
		
