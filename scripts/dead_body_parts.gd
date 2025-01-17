extends Node3D

@onready var left_arm = $LeftArmBody
@onready var right_arm = $RightArmBody
@onready var left_leg = $LeftLegBody
@onready var right_leg = $RightLegBody
@onready var head = $HeadBody

var body_part_behavior = randi_range(0, 4)

func _physics_process(delta: float) -> void:
	match body_part_behavior:
		0: left_arm.visible = false
		1: right_arm.visible = false
		2: left_leg.visible = false
		3: right_leg.visible = false
		4: head.visible = false
