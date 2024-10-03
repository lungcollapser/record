extends CharacterBody3D

const enemy_speed = 3
var enemy_health = 100
var player
@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	nav_agent.target_position = player.global_position
	
	var next_location = nav_agent.get_next_path_position()
	
	if not nav_agent.is_target_reached():
		var direction = (next_location - global_position)
		direction.y = 0
		
		move_and_collide(direction * 1)

	
