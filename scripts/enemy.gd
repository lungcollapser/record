extends CharacterBody3D
class_name Enemy

const ENEMY_ROAMING_SPEED = 0.09
const ENEMY_CHASE_SPEED = 0.03
var enemy_health = clamp(10, 0, 10)
var player
var target = null
var player_hold
var player_attack
var return_check = false
var stun_check = false
var enemy_dead_body_check = true
var aggro_check
var roaming_behavior = randi_range(0, 2)
var enemy_return_one
var enemy_return_two
var enemy_return_three

@onready var enemy_nav = $EnemyNavigation
@onready var enemy = $"."
@onready var enemy_shape = $"EnemyShape"
@onready var dead_body = preload("res://scenes/dead_body.tscn")

func _ready():
	player = get_tree().get_first_node_in_group("player")
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_attack = get_tree().get_first_node_in_group("attack")
	enemy_return_one = get_tree().get_nodes_in_group("pathing")[0]
	enemy_return_two = get_tree().get_nodes_in_group("pathing")[1]
	enemy_return_three = get_tree().get_nodes_in_group("pathing")[2]
	
	
	Events.connect("call_enemy_lose_health", Callable(self, "enemy_lose_health"))
	
	
	
func _physics_process(_delta) -> void:
	enemy_chase()
	enemy_dead_body_spawn()
	
	
	
	#optimize later. still works but only under two conditions.
	#if return_check == false and aggro_check != true and target == null:
	#	await get_tree().physics_frame
	#	enemy_first_position()
	#	await get_tree().create_timer(5).timeout
	#	return_check = true
	#if return_check == true and aggro_check != true and target == null:
	#	await get_tree().physics_frame
	#	enemy_second_position()
	#	await get_tree().create_timer(5).timeout
	#	return_check = false
		
	
	


	
func enemy_chase():
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_CHASE_SPEED
	var enemy_look_position = player.global_position
	enemy_look_position.y = player.global_position.y
	if target == Player and stun_check == false || aggro_check == true and stun_check == false:
		await get_tree().physics_frame
		enemy_nav.set_target_position(player.global_position)
		if enemy_look_position != Vector3.ZERO:
			look_at(enemy_look_position)
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
		

func _on_enemy_area_body_entered(body):
	if body is Player:
		target = Player
		
func _on_enemy_area_body_exited(body):
	if body is Player:
		target = null
	
func enemy_lose_health():
	var stun_chance = randf_range(0, 10)
	var enemy_attack = player_attack.get_collider()
	if enemy_attack == enemy:
		print(enemy_health)
		enemy_health -= 1
		aggro_check = true
		for stun in stun_chance:
			if stun >= 5:
				enemy_stun()
	
		
func enemy_stun():
	stun_check = true
	await get_tree().create_timer(randf_range(1, 3)).timeout
	stun_check = false

func enemy_first_position():
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_ROAMING_SPEED
	var enemy_one_look_position = enemy_return_one.global_position
	enemy_nav.set_target_position(enemy_return_one.global_position)
	if enemy_one_look_position != Vector3.ZERO:
		look_at(Vector3.FORWARD - enemy_one_look_position)
		move_and_collide(enemy_velocity)
		

func enemy_second_position():
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_ROAMING_SPEED
	var enemy_two_look_position = enemy_return_two.global_position
	enemy_nav.set_target_position(enemy_return_two.global_position)
	move_and_collide(enemy_velocity)
	if enemy_two_look_position != Vector3.ZERO:
		look_at(Vector3.FORWARD - enemy_two_look_position)
		move_and_collide(enemy_velocity)
		
		
func enemy_third_position():
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_ROAMING_SPEED
	var enemy_three_look_position = enemy_return_three.global_position
	enemy_nav.set_target_position(enemy_return_three.global_position)
	if enemy_three_look_position != Vector3.ZERO:
		look_at(Vector3.FORWARD - enemy_three_look_position)
		move_and_collide(enemy_velocity)
		


func _on_enemy_roaming_timer_timeout():
	if aggro_check != true and target == null:
		match roaming_behavior:
			0: enemy_first_position()
			1: enemy_second_position()
			2: enemy_third_position()
		print(roaming_behavior)
