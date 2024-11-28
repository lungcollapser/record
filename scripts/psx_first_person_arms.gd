extends Node3D
class_name PSX

@onready var animations = $AnimationPlayer
var enemy_hit_detect
var dead_body_hit_detect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	animations.speed_scale = 2 
	if Input.is_action_just_pressed("leftattack"):
		animations.play("arms_armature|Combat_punch_left")
	elif Input.is_action_just_pressed("rightattack"):
		animations.play("arms_armature|Combat_punch_right")

func _on_psx_arm_hitbox_body_entered(body):
	if body is Enemy:
		Events.emit_signal("call_enemy_lose_health")
		
	if body is DeadBody:
		Events.emit_signal("call_dead_body_explosion")
		
	if body is GarbageBag:
		Events.emit_signal("call_garbage_bag_explosion")
