extends Node3D
class_name FpsCharacter

@onready var punch_animation = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		punch_animation.play("AtkPunch")
	


func _on_fpsarmscollision_body_entered(body):
	if Input.is_action_just_pressed("attack"):
		print("hero")
		Events.emit_signal("call_enemy_lose_health")
