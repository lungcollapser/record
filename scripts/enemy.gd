extends CharacterBody3D
class_name Enemy

const ENEMY_ROAMING_SPEED = 0.02
const ENEMY_CHASE_SPEED = 0.002
var enemy_health = clamp(10, 0, 10)
var player
var target = null
var player_hold
var player_attack
var return_check = false
var enemy_dead_body_check = true
var aggro_check
var rng = RandomNumberGenerator.new()
var enemy_return_one
var enemy_return_two
var enemy_return_three
var enemy_positions = [enemy_return_one, enemy_return_two, enemy_return_three]

@onready var enemy_timer = $EnemyTimer
@onready var eye_hitbox_one = $EyeHitbox1
@onready var eye_hitbox_two = $EyeHitbox2
@onready var enemy_nav = $EnemyNavigation
@onready var enemy = $"."
@onready var enemy_shape = $"EnemyShape"
@onready var dead_body = preload("res://scenes/dead_body.tscn")


func _ready():
	
	player = get_tree().get_first_node_in_group("player")
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_attack = get_tree().get_first_node_in_group("attack")
	enemy_positions[0] = get_tree().get_nodes_in_group("pathing")[0]
	enemy_positions[1] = get_tree().get_nodes_in_group("pathing")[1]
	enemy_positions[2] = get_tree().get_nodes_in_group("pathing")[2]
	
	
	Events.connect("call_enemy_lose_health", Callable(self, "enemy_lose_health"))
	
func _physics_process(_delta) -> void:
	enemy_dead_body_spawn()
	
	
	#allows enemy to move within every frame. VERY IMPORTANT BUT COULD BE OPTIMIZED
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_ROAMING_SPEED
	move_and_collide(enemy_velocity)
	
func enemy_chase():
	var enemy_velocity = (enemy_nav.get_next_path_position() - global_position).normalized() * ENEMY_CHASE_SPEED
	var enemy_look_position = player.global_position
	enemy_look_position.y = player.global_position.y
	if aggro_check == true || aggro_check == false:
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
				print("stunned")
	
		
func enemy_stun():
	var stun_length = randf_range(0.0, 3.0)
	for stun in stun_length:
		await get_tree().create_timer(stun_length).timeout
	

func enemy_move_positions():
	var roaming_behavior = rng.randi_range(0, 2)
	match roaming_behavior:
		0: enemy_nav.set_target_position(enemy_positions[0].global_position)
		1: enemy_nav.set_target_position(enemy_positions[1].global_position) 
		2: enemy_nav.set_target_position(enemy_positions[2].global_position) 
	if roaming_behavior == 0:
		look_at(enemy_positions[0].global_position)
	elif roaming_behavior == 1:
		look_at(enemy_positions[1].global_position)
	elif roaming_behavior == 2:
		look_at(enemy_positions[2].global_position)



func _on_timer_timeout():
	enemy_move_positions()
	if aggro_check == true:
		pass

		
