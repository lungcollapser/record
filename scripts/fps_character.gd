extends Node3D

@onready var fps_arms_collider = $fpsarmsarea
@onready var punch_animation = $AnimationPlayer
@onready var idle_animation = $AnimationPlayer
var enemy_shape

func _ready():
	enemy_shape = get_tree().get_nodes_in_group("enemyshape")[0]

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("attack"):
		punch_animation.play("AtkPunch")
	
