extends RigidBody3D

var pick_up
@onready var dead_body_shape = $deadbodyshape

func _ready() -> void:
	pick_up = get_tree().get_nodes_in_group("pickup")[0]
	


func _physics_process(_delta: float) -> void:
	var dismember_collider = pick_up.get_collider()
	if Input.is_action_just_pressed("attack") and dismember_collider != null and dismember_collider.is_in_group("Dismember"):
		visible = false
		dead_body_shape.disabled = true
