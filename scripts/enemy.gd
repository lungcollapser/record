extends CharacterBody3D
class_name Enemy

const ENEMY_SPEED = 0.07
var enemy_health = clamp(3, 0, 3)
var player
var target = null
var player_hold
var player_attack
var enemy_return_one
var enemy_return_two

var knockback
var enemy_dead_body_check = true
@onready var enemy = $"."
@onready var enemy_shape = $"EnemyShape"
@onready var nav_agent = $EnemyNavigation
@onready var dead_body = preload("res://scenes/dead_body.tscn")

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_attack = get_tree().get_first_node_in_group("attack")
	enemy_return_one = get_tree().get_nodes_in_group("pathing")[0]
	enemy_return_two = get_tree().get_nodes_in_group("pathing")[1]
	
	Events.connect("call_enemy_lose_health", Callable(self, "enemy_lose_health"))
	
	
	
func _physics_process(_delta: float) -> void:
	enemy_chase()
	enemy_dead_body_spawn()
	enemy_roaming();
	

	
func enemy_chase():
	var enemy_velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
	var enemy_look_position = player.global_position
	enemy_look_position.y = player.global_position.y
	if target == Player:
		await get_tree().physics_frame
		nav_agent.set_target_position(player.global_position)
		if enemy_look_position != Vector3.ZERO:
			look_at(enemy_look_position)
			move_and_collide(enemy_velocity)
			
func enemy_roaming():
	var enemy_velocity = (nav_agent.get_next_path_position() - global_position).normalized() * ENEMY_SPEED
	var enemy_look_position = player.global_position
	enemy_look_position.y = player.global_position.y
	if target == null:
		nav_agent.set_target_position(enemy_return_one.global_position)
		move_and_collide(enemy_velocity)
	
func enemy_dead_body_spawn():
	var dead_body_instance = dead_body.instantiate()
	if enemy_health == 0 and enemy_dead_body_check == true:
		enemy_dead_body_check = false
		visible = false
		enemy_shape.disabled = true
		get_parent().add_child(dead_body_instance)
		dead_body_instance.global_position = enemy_shape.global_position
		SanityBar.value -= 20
		

func _on_enemy_area_body_entered(body: Node3D):
	if body is Player:
		target = Player
		
func _on_enemy_area_body_exited(body: Node3D):
	if body is Player:
		target = null
	
func enemy_lose_health():
	var enemy_attack = player_attack.get_collider()
	if enemy_attack == enemy:
		print(enemy_health)
		enemy_health -= 1
		if enemy_health > 1:
			enemy_knockback()
		
		
func enemy_knockback():
	var MAX_KNOCKBACK = -2
	var MIN_KNOCKBACK = -1
	var knockback_speed = 0.5
	var motion = Vector3()
	var rand_knockback = MIN_KNOCKBACK + (randf() * MAX_KNOCKBACK)
	motion.x = rand_knockback * knockback_speed
	move_and_collide(motion)
	
	
