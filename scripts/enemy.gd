extends CharacterBody3D
class_name Enemy

const ENEMY_SPEED = 0.06
var enemy_health = clamp(3, 0, 3)
var enemy_damage
var player
var player_area
var target
var enemy_navigation_link
var player_hold
var player_pickup
var hit_detec_check
var pathing
var bodies = 1
var enemy_dead_body_check = true
@onready var enemy_shape = $"EnemyShape"
@onready var nav_agent = $EnemyNavigation
@onready var dead_body = preload("res://scenes/dead_body.tscn")




func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player_hold = get_tree().get_nodes_in_group("hold")[0]
	player_pickup = get_tree().get_nodes_in_group("pickup")[0]
	pathing = get_tree().get_nodes_in_group("pathing")[0]
	
	Events.connect("call_enemy_lose_health", Callable(self, "enemy_lose_health"))
	
	
	
func _physics_process(_delta: float) -> void:
	enemy_chase()
	enemy_dead_body_spawn()
	
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
		

func enemy_dead_body_spawn():
	var dead_body_instance = dead_body.instantiate()
	if enemy_health == 0 and enemy_dead_body_check == true:
		enemy_dead_body_check = false
		visible = false
		enemy_shape.disabled = true
		get_parent().add_child(dead_body_instance)
		dead_body_instance.global_position = enemy_shape.global_position
		

func _on_enemy_area_body_entered(body: Node3D):
	if body is Player:
		target = Player
		
	

func _on_enemy_area_body_exited(body: Node3D):
	if body is Player:
		target = null
	
func enemy_lose_health():
	if Input.is_action_just_pressed("attack"):
		print(enemy_health)
		enemy_health -= 1
