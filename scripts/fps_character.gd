extends Node3D


@onready var punch_animation = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("attack"):
		punch_animation.play("AtkPunch")
	
