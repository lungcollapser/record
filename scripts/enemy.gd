extends CharacterBody3D

const enemy_speed = 3
var enemy_health = 100
var player = null
@export var player_path : NodePath
@onready var nav_agent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)
	
func _process(delta: float):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * enemy_speed
	
	move_and_slide()
	
