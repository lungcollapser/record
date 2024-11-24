extends Node3D

var max_health
var health = 100

func _ready() -> void:
	health = max_health

func take_damage(attack):
	health -= attack
	
	if health <= 0:
		get_parent().queue_free()
