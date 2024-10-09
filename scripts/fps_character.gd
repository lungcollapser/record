extends Node3D

@onready var fps_arms_collider = $fpsarmsarea
@onready var punch_animation = $AnimationPlayer
@onready var idle_animation = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("attack"):
		punch_animation.play("AtkPunch")
		
	var punch_collider = fps_arms_collider.get_collider()
	if Input.is_action_pressed("attack") and punch_collider is Enemy2:
		Enemy.enemy_lose_health()
