extends Node3D
class_name PSX
@onready var animations = $AnimationPlayer


func _physics_process(delta: float) -> void:
	animations.speed_scale = 2
	if Input.is_action_just_pressed("attack"):
		animations.play("arms_armature|Combat_punch_left")
